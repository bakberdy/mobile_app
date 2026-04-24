platform :ios do
  desc "Build a signed IPA for the given flavor. Returns the IPA path."
  private_lane :build do |options|
    flavor = options[:flavor] || UI.user_error!("build requires flavor:<development|staging|production>")
    cfg    = flavor_config(flavor)

    install_signing(flavor)

    dart_args = flutter_dart_define_args(flavor)

    export_plist = write_export_options_plist(
      bundle_id:    cfg[:bundle_id],
      profile_name: provisioning_profile_name(flavor),
    )

    clean_previous_ipas

    Dir.chdir(PROJECT_ROOT) do
      cmd = [
        "flutter", "build", "ipa",
        "--flavor", flavor,
        "--release",
        *dart_args,
        "--export-options-plist=#{export_plist}",
      ]
      if ci? && !ENV["GITHUB_RUN_ID"].to_s.empty?
        run_id = ENV["GITHUB_RUN_ID"]
        cmd += ["--build-number", run_id]
        UI.message("iOS build number: #{run_id} (GITHUB_RUN_ID)")
      end
      sh(*cmd)
    end

    ipa = find_built_ipa
    UI.user_error!("IPA not found under build/ios/ipa") if ipa.nil?
    ipa
  end
end
