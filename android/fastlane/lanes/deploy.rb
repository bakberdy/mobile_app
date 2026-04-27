platform :android do
  desc "Upload the built AAB to Google Play for the given flavor."
  private_lane :deploy do |options|
    flavor = options[:flavor] || UI.user_error!("deploy requires flavor:<development|production>")
    cfg    = flavor_config(flavor)
    aab    = options[:aab] || find_built_aab(flavor)
    UI.user_error!("No AAB found at #{aab_path(flavor)}. Run `build` first.") if aab.nil?

    track          = resolve_track(options[:track])
    release_status = resolve_release_status(options[:release_status])

    upload_to_play_store(
      package_name:            cfg[:package_name],
      aab:                     aab,
      track:                   track,
      release_status:          release_status,
      json_key_data:           play_service_account_json_data,
      skip_upload_apk:         true,
      skip_upload_metadata:    true,
      skip_upload_changelogs:  true,
      skip_upload_images:      true,
      skip_upload_screenshots: true,
    )
  end
end
