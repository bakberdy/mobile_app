# iOS: builds and TestFlight

## Flavors and app config


| Make target           | Flutter flavor | `dart-define-from-file`              |
| --------------------- | -------------- | ------------------------------------ |
| `ios-ipa-development` | `development`  | `config/run/config.development.json` |
| `ios-ipa-staging`     | `staging`      | `config/run/config.stage.json`       |
| `ios-ipa-production`  | `production`   | `config/run/config.production.json`  |


Optional: `EXPORT_OPTIONS_PLIST=ios/fastlane/ExportOptions.plist` on `make` targets. App API URL and environment come only from those JSON files (no extra Action secrets for that on iOS).

## Fastlane

From `ios/` after `bundle install`:


| Lane               | Bundle ID                             |
| ------------------ | ------------------------------------- |
| `beta_development` | `com.bakberdi.mobile-app.development` |
| `beta_staging`     | `com.bakberdi.mobile-app.staging`     |
| `beta_production`  | `com.bakberdi.mobile-app`             |


**Local:** unset `CI`. Fastlane loads `**ios/keys/.env`** (required). Copy `ios/keys/.env.example` → `ios/keys/.env`. Paths in `.env` are relative to `**ios/**` unless absolute.

**CI:** `ios-upload-to-testflight.yml` sets `CI=true`, exposes secrets as env vars using the **full names** in the tables (decodes `APP_STORE_CONNECT_API_KEY` to a temp file and sets `APP_STORE_CONNECT_API_KEY_PATH` for Fastlane), then runs `bundle exec fastlane beta_<flavor>`. Tag releases use `flavor: production`.

## Keys: one name, two places

Use **the same identifier** in `ios/keys/.env` and as the **GitHub Actions secret name** wherever the cell says “same”.

### Shared (same key in `.env` and in Actions)


| Key                                         | Meaning                                 |
| ------------------------------------------- | --------------------------------------- |
| `APP_STORE_CONNECT_KEY_ID`                  | App Store Connect API key id            |
| `APP_STORE_CONNECT_ISSUER_ID`               | API issuer id                           |
| `IOS_BUILD_CERTIFICATE_PASSWORD`            | Password for the distribution `.p12`    |
| `IOS_PROVISIONING_PROFILE_NAME_DEVELOPMENT` | Exact profile name (development bundle) |
| `IOS_PROVISIONING_PROFILE_NAME_STAGING`     | Exact profile name (staging bundle)     |
| `IOS_PROVISIONING_PROFILE_NAME_PRODUCTION`  | Exact profile name (production bundle)  |


### Local `.env` = file path · Actions = base64 of that file


| Concept                                   | `ios/keys/.env`                                | GitHub secret                                          |
| ----------------------------------------- | ---------------------------------------------- | ------------------------------------------------------ |
| App Store Connect API key (`.p8`)         | `APP_STORE_CONNECT_API_KEY_PATH`               | `APP_STORE_CONNECT_API_KEY` (full PEM or base64 of it) |
| Distribution certificate (`.p12`)         | `IOS_BUILD_CERTIFICATE_PATH`                   | `IOS_BUILD_CERTIFICATE_BASE64`                         |
| Provisioning profile (`.mobileprovision`) | `IOS_BUILD_PROVISION_PROFILE_PATH_DEVELOPMENT` | `IOS_BUILD_PROVISION_PROFILE_BASE64_DEVELOPMENT`       |
|                                           | `IOS_BUILD_PROVISION_PROFILE_PATH_STAGING`     | `IOS_BUILD_PROVISION_PROFILE_BASE64_STAGING`           |
|                                           | `IOS_BUILD_PROVISION_PROFILE_PATH_PRODUCTION`  | `IOS_BUILD_PROVISION_PROFILE_BASE64_PRODUCTION`        |


For a given workflow run, only the row matching `**inputs.flavor`** must be set among the three profile pairs (plus the shared secrets). Automatic signing locally: leave the three `IOS_BUILD_PROVISION_PROFILE_PATH_*` lines empty; Xcode handles signing.

## Apple side

App Store distribution profiles and App Store Connect apps for the three bundle IDs above. API key role must allow upload (e.g. App Manager). Workflow artifact on success: `ios-<flavor>-ipa`.

## Related

- Android CI secrets: [android/build.md](../android/build.md)

