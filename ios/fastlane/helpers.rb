require "fileutils"
require "shellwords"

FLAVORS = {
  "development" => {
    bundle_id:        "com.bakberdi.mobile-app.development",
    dart_define_file: "config/run/config.development.json",
    env_suffix:       "DEVELOPMENT",
  },
  "production" => {
    bundle_id:        "com.bakberdi.mobile-app",
    dart_define_file: "config/run/config.production.json",
    env_suffix:       "PRODUCTION",
  },
}.freeze

DART_DEFINE_KEYS = %w[API_URL ENVIRONMENT].freeze

def flavor_config(flavor)
  FLAVORS[flavor] || UI.user_error!("Unknown flavor: #{flavor}. Use development or production.")
end

def flutter_dart_define_args(flavor)
  cfg = flavor_config(flavor)
  if ci?
    sfx = cfg[:env_suffix]
    DART_DEFINE_KEYS.map do |key|
      env_name = "#{sfx}_#{key}"
      val = ENV[env_name].to_s
      if val.empty?
        UI.user_error!(
          "Set repository secret #{env_name} for CI (same value as \"#{key}\" in #{cfg[:dart_define_file]}; see config/run/config.example.json). " \
          "Locally, unset CI and use --dart-define-from-file instead.",
        )
      end
      "--dart-define=#{key}=#{val}"
    end
  else
    rel = cfg[:dart_define_file]
    full = File.join(PROJECT_ROOT, rel)
    UI.user_error!("Missing #{rel}") unless File.file?(full)
    ["--dart-define-from-file=#{rel}"]
  end
end

def ci?
  !ENV["CI"].to_s.empty?
end

def load_local_env_file
  return if ci?

  path = File.join(IOS_DIR, "keys", ".env")
  UI.user_error!("Missing #{path}. Copy ios/keys/.env.example to ios/keys/.env and fill values.") unless File.file?(path)

  File.readlines(path, chomp: true).each do |line|
    stripped = line.strip
    next if stripped.empty? || stripped.start_with?("#")

    idx = stripped.index("=")
    next if idx.nil? || idx < 1

    key = stripped[0...idx].strip
    val = stripped[(idx + 1)..].strip
    val = val[1..-2] if (val.start_with?('"') && val.end_with?('"')) || (val.start_with?("'") && val.end_with?("'"))
    ENV[key] = val unless key.empty?
  end
end

def resolve_local_paths
  return if ci?

  %w[
    APP_STORE_CONNECT_API_KEY_PATH
    IOS_BUILD_CERTIFICATE_PATH
    IOS_BUILD_PROVISION_PROFILE_PATH_DEVELOPMENT
    IOS_BUILD_PROVISION_PROFILE_PATH_PRODUCTION
  ].each do |key|
    raw = ENV[key].to_s
    next if raw.empty? || File.file?(raw)

    absolute = File.expand_path(raw, IOS_DIR)
    ENV[key] = absolute if File.file?(absolute)
  end
end

def provisioning_profile_name(flavor)
  ENV["IOS_PROVISIONING_PROFILE_NAME_#{flavor_config(flavor)[:env_suffix]}"].to_s
end

def provisioning_profile_path(flavor)
  ENV["IOS_BUILD_PROVISION_PROFILE_PATH_#{flavor_config(flavor)[:env_suffix]}"].to_s
end

def write_export_options_plist(bundle_id:, profile_name:)
  out_absolute = File.join(PROJECT_ROOT, "build", "ios", "flutter_export_options.plist")
  FileUtils.mkdir_p(File.dirname(out_absolute))

  File.write(out_absolute, <<~XML)
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>method</key>
      <string>app-store</string>
      <key>uploadBitcode</key>
      <false/>
      <key>uploadSymbols</key>
      <true/>
      <key>signingStyle</key>
      <string>manual</string>
      <key>provisioningProfiles</key>
      <dict>
        <key>#{bundle_id}</key>
        <string>#{profile_name}</string>
      </dict>
    </dict>
    </plist>
  XML

  "build/ios/flutter_export_options.plist"
end

def profile_internal_name(profile_path)
  raw   = `security cms -D -i #{profile_path.shellescape} 2>/dev/null`
  match = raw.match(%r{<key>Name</key>\s*<string>([^<]+)</string>})
  match ? match[1].strip : ""
end

def ensure_profile!(flavor)
  cfg    = flavor_config(flavor)
  suffix = cfg[:env_suffix]

  name = provisioning_profile_name(flavor)
  path = provisioning_profile_path(flavor)

  UI.user_error!("IOS_PROVISIONING_PROFILE_NAME_#{suffix} is not set") if name.empty?
  UI.user_error!("IOS_BUILD_PROVISION_PROFILE_PATH_#{suffix} is not set") if path.empty?
  UI.user_error!("Provisioning profile file not found: #{path}") unless File.file?(path)

  actual = profile_internal_name(path)
  if actual.empty?
    UI.user_error!("Could not read Name from #{path}. Is it a valid .mobileprovision file?")
  end
  if actual != name
    UI.user_error!(
      "Profile name mismatch for #{flavor}: IOS_PROVISIONING_PROFILE_NAME_#{suffix}=\"#{name}\" " \
      "but #{path} has Name=\"#{actual}\".",
    )
  end
end

def install_signing(flavor)
  ensure_profile!(flavor)

  install_provisioning_profile(path: provisioning_profile_path(flavor))

  return unless ci?

  cert_path = ENV["IOS_BUILD_CERTIFICATE_PATH"].to_s
  UI.user_error!("IOS_BUILD_CERTIFICATE_PATH is not set") if cert_path.empty?
  UI.user_error!("Certificate file not found: #{cert_path}") unless File.file?(cert_path)

  keychain_password = ENV.fetch("IOS_KEYCHAIN_PASSWORD", "build_keychain_temp")
  create_keychain(
    name:             "build.keychain",
    password:         keychain_password,
    default_keychain: true,
    unlock:           true,
    timeout:          3600,
    lock_when_sleeps: false,
  )
  import_certificate(
    certificate_path:     cert_path,
    certificate_password: ENV.fetch("IOS_BUILD_CERTIFICATE_PASSWORD"),
    keychain_name:        "build.keychain",
    keychain_password:    keychain_password,
  )
end

def clean_previous_ipas
  Dir.glob(File.join(PROJECT_ROOT, "build/ios/ipa/*.ipa")).each { |f| File.delete(f) }
end

def prepare_app_store_connect_api_key
  key_path = ENV["APP_STORE_CONNECT_API_KEY_PATH"]
  UI.user_error!("APP_STORE_CONNECT_API_KEY_PATH must point to the App Store Connect API .p8 file") if key_path.to_s.empty? || !File.file?(key_path)

  app_store_connect_api_key(
    key_id:       ENV.fetch("APP_STORE_CONNECT_KEY_ID"),
    issuer_id:    ENV.fetch("APP_STORE_CONNECT_ISSUER_ID"),
    key_filepath: key_path,
    duration:     1200,
    in_house:     false,
  )
end

def find_built_ipa
  Dir.glob(File.join(PROJECT_ROOT, "build/ios/ipa/*.ipa")).first
end
