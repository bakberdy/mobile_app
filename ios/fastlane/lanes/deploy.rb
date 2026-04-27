platform :ios do
  desc "Upload the built IPA to TestFlight for the given flavor."
  private_lane :deploy do |options|
    flavor = options[:flavor] || UI.user_error!("deploy requires flavor:<development|production>")
    cfg    = flavor_config(flavor)
    ipa    = options[:ipa] || find_built_ipa
    UI.user_error!("No IPA found under build/ios/ipa. Run `build` first.") if ipa.nil?

    opts = {
      ipa:                               ipa,
      app_identifier:                    cfg[:bundle_id],
      skip_waiting_for_build_processing: true,
      api_key:                           lane_context[SharedValues::APP_STORE_CONNECT_API_KEY],
    }
    log_path = ENV["TESTFLIGHT_CHANGELOG_FILE"].to_s
    if !log_path.empty? && File.file?(log_path)
      text = File.read(log_path, encoding: "UTF-8").strip
      opts[:changelog] = text if !text.empty?
    end
    upload_to_testflight(**opts)
  end
end
