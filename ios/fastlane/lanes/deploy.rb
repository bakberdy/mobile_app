platform :ios do
  desc "Upload the built IPA to TestFlight for the given flavor."
  private_lane :deploy do |options|
    flavor = options[:flavor] || UI.user_error!("deploy requires flavor:<development|staging|production>")
    cfg    = flavor_config(flavor)
    ipa    = options[:ipa] || find_built_ipa
    UI.user_error!("No IPA found under build/ios/ipa. Run `build` first.") if ipa.nil?

    upload_to_testflight(
      ipa:                               ipa,
      app_identifier:                    cfg[:bundle_id],
      skip_waiting_for_build_processing: true,
      api_key:                           lane_context[SharedValues::APP_STORE_CONNECT_API_KEY],
    )
  end
end
