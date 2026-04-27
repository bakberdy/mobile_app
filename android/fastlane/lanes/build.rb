platform :android do
  desc "Build a signed AAB for the given flavor. Returns the AAB path."
  private_lane :build do |options|
    flavor = options[:flavor] || UI.user_error!("build requires flavor:<development|production>")
    flavor_config(flavor)

    dart_args = flutter_dart_define_args(flavor)

    clean_previous_aab(flavor)

    Dir.chdir(PROJECT_ROOT) do
      cmd = [
        "flutter", "build", "appbundle",
        "--flavor", flavor,
        "--release",
        *dart_args,
      ]
      if ci? && !ENV["GITHUB_RUN_ID"].to_s.empty?
        run_id = ENV["GITHUB_RUN_ID"]
        cmd += ["--build-number", run_id]
        UI.message("Android build number: #{run_id} (GITHUB_RUN_ID)")
      end
      sh(*cmd)
    end

    aab = find_built_aab(flavor)
    UI.user_error!("AAB not found at #{aab_path(flavor)}") if aab.nil?
    aab
  end
end
