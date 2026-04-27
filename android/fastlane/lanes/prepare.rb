platform :android do
  desc "Load local env file, resolve paths, and ensure signing properties exist for the given flavor."
  private_lane :prepare do |options|
    flavor = options[:flavor] || UI.user_error!("prepare requires flavor:<development|production>")
    flavor_config(flavor)

    load_local_env_file
    resolve_local_paths
    ensure_key_properties!(flavor)
  end
end
