# iOS CI/CD (step by step)

## Step 1 — `ios/keys/.env` (local Fastlane)

Copy `ios/keys/.env.example` → `ios/keys/.env`. Paths are relative to `ios/` unless absolute.

**Same names as GitHub for shared values** (see Step 6 for Actions-specific columns):

| Key | Meaning |
|-----|---------|
| `APP_STORE_CONNECT_API_KEY_PATH` | Path to App Store Connect API `.p8` |
| `APP_STORE_CONNECT_KEY_ID` | API key id |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer id |
| `IOS_BUILD_CERTIFICATE_PATH` | Distribution `.p12` path |
| `IOS_BUILD_CERTIFICATE_PASSWORD` | `.p12` password |
| `IOS_PROVISIONING_PROFILE_NAME_DEVELOPMENT` | Exact profile name (development bundle) |
| `IOS_PROVISIONING_PROFILE_NAME_STAGING` | Exact profile name (staging bundle) |
| `IOS_PROVISIONING_PROFILE_NAME_PRODUCTION` | Exact profile name (production bundle) |
| `IOS_BUILD_PROVISION_PROFILE_PATH_DEVELOPMENT` | Path to development `.mobileprovision` |
| `IOS_BUILD_PROVISION_PROFILE_PATH_STAGING` | Path to staging `.mobileprovision` |
| `IOS_BUILD_PROVISION_PROFILE_PATH_PRODUCTION` | Path to production `.mobileprovision` |

## Step 2 — App Store Connect API key

**App Store Connect → Users and Access → Integrations → App Store Connect API → Generate API Key.**

- Role: **App Manager** (or Admin).
- You get: `.p8` file → `APP_STORE_CONNECT_API_KEY_PATH` in `.env`, plus `APP_STORE_CONNECT_KEY_ID` and `APP_STORE_CONNECT_ISSUER_ID`.

## Step 3 — Distribution certificate (`.p12` + password)

1. **Keychain Access** → **Certificate Assistant** → **Request a Certificate From a Certificate Authority** → save the CSR to disk.
2. **developer.apple.com** → **Certificates** → add **Apple Distribution** → upload that CSR.
3. **Keychain** → **login** → find the new **Apple Distribution** cert → **Export** → set a password → save as `.p12` under `ios/keys/`. Set `IOS_BUILD_CERTIFICATE_PATH` and `IOS_BUILD_CERTIFICATE_PASSWORD` in `.env` (and cert secrets in Step 6 for CI).

## Step 4 — Provisioning profiles (one per flavor)

**developer.apple.com** → **Profiles** → **Register a New Profile** → type **App Store** → pick each app ID (per flavor) → link the **Apple Distribution** cert from step 3 → download each `.mobileprovision`.

Use the profile **Name** exactly as in `IOS_PROVISIONING_PROFILE_NAME_*`; file paths in `IOS_BUILD_PROVISION_PROFILE_PATH_*`.

## Step 5 — Deploy locally (Fastlane + Makefile)

One-time: `cd ios && bundle install`.

From **repo root**:

```bash
make -f MakeFile ios-production-deploy
# or: ios-staging-deploy, ios-development-deploy
```

Runs `beta_production` / `beta_staging` / `beta_development` (IPA + TestFlight). Requires Step 1 `.env` and `CI` **unset** so Fastlane uses JSON for dart-defines (see table below).

## Step 6 — GitHub Actions secrets

**Repo → Settings → Secrets and variables → Actions → New repository secret.**

| Secret | Value |
|--------|--------|
| `APP_STORE_CONNECT_KEY_ID` | API key id |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer id |
| `APP_STORE_CONNECT_API_KEY` | Full `.p8` PEM, or base64 of that file (workflow writes a temp path) |
| `IOS_BUILD_CERTIFICATE_BASE64` | `base64 -i your.p12 \| pbcopy` (macOS) |
| `IOS_BUILD_CERTIFICATE_PASSWORD` | `.p12` password |
| `IOS_BUILD_PROVISION_PROFILE_BASE64_DEVELOPMENT` | Base64 of development `.mobileprovision` |
| `IOS_PROVISIONING_PROFILE_NAME_DEVELOPMENT` | Exact profile name (must match file) |
| `IOS_BUILD_PROVISION_PROFILE_BASE64_STAGING` | Base64 of staging profile |
| `IOS_PROVISIONING_PROFILE_NAME_STAGING` | Exact staging profile name |
| `IOS_BUILD_PROVISION_PROFILE_BASE64_PRODUCTION` | Base64 of production profile |
| `IOS_PROVISIONING_PROFILE_NAME_PRODUCTION` | Exact production profile name |

**Build config (flavor-scoped, not iOS-only):** same JSON keys as `config/run/config.example.json` (`API_URL`, `ENVIRONMENT`, …). **Secret name = `<FLAVOR>_<KEY>`** with **FLAVOR** uppercase: `DEVELOPMENT` | `STAGING` | `PRODUCTION` (matches Fastlane `env_suffix`). The secret **value** is the same string as in the matching `config/run/config.<flavor>.json` for that key. Local builds still use those files; CI passes `--dart-define` from these secrets.

| Secret | JSON field in that flavor’s `config.*.json` |
|--------|---------------------------------------------|
| `DEVELOPMENT_API_URL` | `API_URL` |
| `DEVELOPMENT_ENVIRONMENT` | `ENVIRONMENT` |
| `STAGING_API_URL` | `API_URL` |
| `STAGING_ENVIRONMENT` | `ENVIRONMENT` |
| `PRODUCTION_API_URL` | `API_URL` |
| `PRODUCTION_ENVIRONMENT` | `ENVIRONMENT` |

For a given workflow run, the workflow `inputs.flavor` must have its profile pair, the build-config pair for that flavor, and all shared rows above. Tag-based release uses **production** only for iOS (see Step 7).

## Step 7 — CI: what runs and how

- **Workflow:** `.github/workflows/ios-upload-to-testflight.yml` (reusable). It sets `CI=true`, decodes signing + API key, passes secrets into the job env, then runs `cd ios && bundle exec fastlane beta_<flavor>`.
- **Tag releases:** `.github/workflows/release-on-tag.yml` calls that workflow with `flavor: production` after the version step. Pushing a release tag runs the iOS job if the rest of the release pipeline is set up; you need all **production** + **shared** secrets from Step 6.
- **Artifact:** on success, the job uploads `build/ios/ipa/*.ipa` as `ios-<flavor>-ipa`.
- **Other flavors in CI:** add a workflow (or `workflow_dispatch` input) that calls `ios-upload-to-testflight.yml` with `flavor: staging` or `development` and `secrets: inherit`. Only the secrets for that flavor need to be non-empty for that run (plus shared keys).

## Reference (quick)

| Flutter flavor | Bundle ID | Config JSON (local / `dart-define-from-file`) |
|----------------|-----------|-----------------------------------------------|
| `development` | `com.bakberdi.mobile-app.development` | `config/run/config.development.json` |
| `staging` | `com.bakberdi.mobile-app.staging` | `config/run/config.staging.json` |
| `production` | `com.bakberdi.mobile-app` | `config/run/config.production.json` |

| Fastlane lane | Flavor |
|---------------|--------|
| `beta_development` | development |
| `beta_staging` | staging |
| `beta_production` | production |

**Dart / compile-time defines:** `API_URL` and `ENVIRONMENT` come from `lib/app_config.dart`. **Local:** `config/run/*.json`. **CI:** secrets `<FLAVOR>_<KEY>` (see Step 6). New key: add to `config.example.json` + `DART_DEFINE_KEYS` in `ios/fastlane/helpers.rb` + `String.fromEnvironment` in Dart, then add e.g. `DEVELOPMENT_NEWKEY`, `STAGING_NEWKEY`, `PRODUCTION_NEWKEY` in GitHub and in the workflow `env` for the iOS job.

**Android CI:** [.github/docs/android/build.md](android/build.md)
