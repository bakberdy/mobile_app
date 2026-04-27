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
      if ci? && (bn = ci_build_number_from_github_run_id)
        cmd += ["--build-number", bn]
        UI.message("Android build number: #{bn} (last 5 decimal digits of GITHUB_RUN_ID, 0 → 1)")
      end
      sh(*cmd)
    end

    aab = find_built_aab(flavor)
    UI.user_error!("AAB not found at #{aab_path(flavor)}") if aab.nil?
    aab
  end
end
