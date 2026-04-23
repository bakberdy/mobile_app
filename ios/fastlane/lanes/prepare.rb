platform :ios do
  desc "Load local env file, resolve paths, and prepare the App Store Connect API key."
  private_lane :prepare do
    load_local_env_file
    resolve_local_paths
    prepare_app_store_connect_api_key
  end
end
