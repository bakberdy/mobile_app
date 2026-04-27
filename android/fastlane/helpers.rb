require "base64"
require "fileutils"

FLAVORS = {
  "development" => {
    package_name:     "com.bakberdi.mobile_app.development",
    dart_define_file: "config/run/config.development.json",
    env_suffix:       "DEVELOPMENT",
  },
  "production" => {
    package_name:     "com.bakberdi.mobile_app",
    dart_define_file: "config/run/config.production.json",
    env_suffix:       "PRODUCTION",
  },
}.freeze

DART_DEFINE_KEYS = %w[API_URL ENVIRONMENT].freeze

DEFAULT_PLAY_TRACK = "internal".freeze

def flavor_config(flavor)
  FLAVORS[flavor] || UI.user_error!("Unknown flavor: #{flavor}. Use development or production.")
end

def ci?
  !ENV["CI"].to_s.empty?
end

# Android `versionCode` must be at most 2_100_000_000. `GITHUB_RUN_ID` can exceed that.
# Use the last five decimal digits (via `% 100_000` → 0..99_999). Map 0 → 1 (valid positive code).
# Keep in sync with `.github/workflows/android-upload-to-play.yml` and `ios/fastlane/helpers.rb`.
def ci_build_number_from_github_run_id
  raw = ENV["GITHUB_RUN_ID"].to_s
  return nil if raw.empty?

  n = raw.to_i % 100_000
  n = 1 if n.zero?
  n.to_s
end

def load_local_env_file
  return if ci?

  path = File.join(ANDROID_DIR, "keys", ".env")
  return unless File.file?(path)

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
    PLAY_STORE_SERVICE_ACCOUNT_JSON_PATH
  ].each do |key|
    raw = ENV[key].to_s
    next if raw.empty? || File.file?(raw)

    absolute = File.expand_path(raw, ANDROID_DIR)
    ENV[key] = absolute if File.file?(absolute)
  end
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

def key_properties_path(flavor)
  File.join(ANDROID_DIR, "key.#{flavor}.properties")
end

def read_store_file_raw_from_properties(props_path)
  return nil unless File.file?(props_path)

  File.readlines(props_path, chomp: true).each do |line|
    stripped = line.strip
    next if stripped.empty? || stripped.start_with?("#")
    m = stripped.match(%r{^\s*storeFile\s*=\s*(.+?)\s*$})
    return m[1]&.strip if m
  end
  nil
end

# Matches android/app/build.gradle.kts resolveKeyStoreFile: absolute = as-is; else relative to android/.
def resolve_store_file_to_path(raw)
  return File.expand_path(raw) if raw.start_with?("/")

  File.expand_path(raw, ANDROID_DIR)
end

def ensure_key_properties!(flavor)
  if ci?
    write_key_properties_from_ci!(flavor)
    return
  end

  path = key_properties_path(flavor)
  unless File.file?(path)
    UI.user_error!(
      "Missing #{path}. See .github/docs/android.md (Step A2) — generate the keystore and create key.#{flavor}.properties before running Fastlane locally.",
    )
  end

  raw = read_store_file_raw_from_properties(path)
  if raw.nil? || raw.empty?
    UI.user_error!("#{path} must contain a line storeFile=… pointing to your upload .jks (see .github/docs/android.md Step A2).")
  end

  keystore = resolve_store_file_to_path(raw)
  return if File.file?(keystore)

  UI.user_error!(
    "Keystore not found. storeFile in #{path} is #{raw.inspect} → resolved to #{keystore}\n" \
    "A path like /keys/... is the root of the disk, not a folder in your home. " \
    "Use the full path to the .jks (e.g. under #{Dir.home}/...) " \
    "or a path relative to the android/ directory (e.g. keys/upload.jks for android/keys/upload.jks).",
  )
end

def write_key_properties_from_ci!(flavor)
  sfx = flavor_config(flavor)[:env_suffix]

  b64    = ENV["ANDROID_KEYSTORE_BASE64_#{sfx}"].to_s
  store  = ENV["ANDROID_KEYSTORE_PASSWORD_#{sfx}"].to_s
  alias_ = ENV["ANDROID_KEY_ALIAS_#{sfx}"].to_s
  key_pw = ENV["ANDROID_KEY_PASSWORD_#{sfx}"].to_s

  UI.user_error!("Set CI secret ANDROID_KEYSTORE_BASE64_#{sfx} (Base64 of the upload .jks).")     if b64.empty?
  UI.user_error!("Set CI secret ANDROID_KEYSTORE_PASSWORD_#{sfx}.")                                if store.empty?
  UI.user_error!("Set CI secret ANDROID_KEY_ALIAS_#{sfx}.")                                        if alias_.empty?
  UI.user_error!("Set CI secret ANDROID_KEY_PASSWORD_#{sfx}.")                                     if key_pw.empty?

  keystore_dir  = ENV["RUNNER_TEMP"].to_s.empty? ? File.join(PROJECT_ROOT, "build", "android-keystores") : ENV["RUNNER_TEMP"]
  FileUtils.mkdir_p(keystore_dir)
  keystore_path = File.join(keystore_dir, "upload-#{flavor}.jks")
  File.binwrite(keystore_path, Base64.decode64(b64.gsub(/\s+/, "")))
  UI.user_error!("Decoded keystore is empty for #{flavor}. Recheck ANDROID_KEYSTORE_BASE64_#{sfx}.") if File.size(keystore_path) <= 0

  File.write(key_properties_path(flavor), <<~PROPS)
    storeFile=#{keystore_path}
    storePassword=#{store}
    keyAlias=#{alias_}
    keyPassword=#{key_pw}
  PROPS
end

def play_service_account_json_data
  raw = ENV["PLAY_STORE_SERVICE_ACCOUNT_JSON"].to_s
  return raw unless raw.empty?

  path = ENV["PLAY_STORE_SERVICE_ACCOUNT_JSON_PATH"].to_s
  UI.user_error!(
    "Set PLAY_STORE_SERVICE_ACCOUNT_JSON_PATH (local) or PLAY_STORE_SERVICE_ACCOUNT_JSON (CI). See .github/docs/android.md (Step B2).",
  ) if path.empty?
  UI.user_error!("Service account JSON file not found: #{path}") unless File.file?(path)

  File.read(path)
end

def aab_path(flavor)
  File.join(PROJECT_ROOT, "build/app/outputs/bundle/#{flavor}Release/app-#{flavor}-release.aab")
end

def find_built_aab(flavor)
  path = aab_path(flavor)
  File.file?(path) ? path : nil
end

def clean_previous_aab(flavor)
  Dir.glob(File.join(PROJECT_ROOT, "build/app/outputs/bundle/#{flavor}Release/*.aab")).each { |f| File.delete(f) }
end

def resolve_track(value)
  candidate = value.to_s
  candidate = ENV["PLAY_TRACK"].to_s if candidate.empty?
  candidate = DEFAULT_PLAY_TRACK     if candidate.empty?

  unless %w[internal alpha beta production].include?(candidate)
    UI.user_error!("Invalid Google Play track '#{candidate}'. Use internal, alpha, beta, or production.")
  end

  candidate
end

# Google Play: while the app (or a new app listing) is still a "draft" in Console,
# the API only accepts `draft` here — "completed" fails with:
# "Only releases with status draft may be created on draft app."
# After the app is fully set up and published at least once, you can set
# PLAY_RELEASE_STATUS=completed (or pass release_status:completed on the lane).
def resolve_release_status(lane_value)
  candidate = lane_value.to_s
  candidate = ENV["PLAY_RELEASE_STATUS"].to_s if candidate.empty?
  candidate = "draft" if candidate.empty?

  unless %w[draft completed inProgress halted].include?(candidate)
    UI.user_error!("Invalid release status '#{candidate}'. Use draft, completed, inProgress, or halted.")
  end

  candidate
end
