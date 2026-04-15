# iOS TestFlight upload (GitHub Actions)

This document describes the reusable workflow `.github/workflows/ios-upload-to-testflight.yml`, which builds the **production** flavor IPA and uploads it to **TestFlight** via Fastlane.

It is invoked from the tag release workflow (for example `upload-ios-to-testflight` in `release-on-tag`) with `secrets: inherit`.

---

## 1. GitHub Actions secrets (required)

Add secrets in the repository: **Settings → Secrets and variables → Actions → New repository secret**. Names are case-sensitive and must match exactly.

These are the **only** secrets this iOS upload workflow reads:

| Secret | Format | Notes |
|--------|--------|--------|
| `PRODUCTION_API_URL` | Plain string (HTTPS URL) | Passed as `--dart-define=API_URL` at build time. Same idea as Android production. |
| `PRODUCTION_ENVIRONMENT` | Plain string | Passed as `--dart-define=ENVIRONMENT`. Must match what the app expects (see `lib/app_config.dart`). |
| `APP_STORE_CONNECT_KEY_ID` | Plain string | Key ID from App Store Connect API key. |
| `APP_STORE_CONNECT_ISSUER_ID` | Plain string | Issuer ID (Users and Access → Integrations → App Store Connect API). |
| `APP_STORE_CONNECT_API_KEY` | PEM **or** base64 of PEM | Full `.p8` file contents (`-----BEGIN …`), or the same file encoded as a single-line base64 string; the workflow accepts both. |
| `IOS_BUILD_CERTIFICATE_BASE64` | Base64 of file | Base64-encoded **iOS Distribution** `.p12` used to sign the app. |
| `IOS_BUILD_CERTIFICATE_PASSWORD` | Plain string | Password for the `.p12`. |
| `IOS_BUILD_PROVISION_PROFILE_BASE64` | Base64 of file | Base64-encoded **App Store** provisioning profile for `com.bakberdi.mobile-app`. |
| `IOS_PROVISIONING_PROFILE_NAME` | Plain string | Exact profile **name** as shown in developer.apple.com or Xcode (must match the installed profile). |

**Rules**

- Values must be **non-empty**; the workflow fails fast if any listed secret is missing.
- The App Store Connect API key needs a role that can upload builds (for example **App Manager** or **Admin**).

No other GitHub secrets are required **by this workflow** for iOS upload. The tag workflow may use additional secrets for other jobs (for example the Android release bot); those are documented in [android/build.md](../android/build.md).

---

## 2. What runs on the runner

1. Checkout, Flutter (stable), `flutter pub get`
2. Ruby + Bundler in `ios/`, then `pod install` in `ios/`
3. Decode API key, certificate, and provisioning profile to temporary paths
4. `bundle exec fastlane beta_production` from `ios/` (`ios/fastlane/Fastfile`)

Fastlane creates a CI keychain, imports the certificate, installs the profile, runs `flutter build ipa --flavor production --release` with the production dart-defines, then `upload_to_testflight` using the API key.

---

## 3. Apple Developer / App Store Connect (manual)

- App ID and App Store Connect app for **`com.bakberdi.mobile-app`** (production).
- Valid **Distribution** certificate and **App Store** provisioning profile for that bundle ID.
- App Store Connect **API** key with upload-capable access.

Optional: register separate App IDs for `com.bakberdi.mobile-app.staging` and `com.bakberdi.mobile-app.development` if you distribute those flavors outside this pipeline.

---

## 4. Artifacts

On success, the workflow may upload the built IPA as an artifact named `ios-production-ipa` for debugging.

---

## 5. Related docs

- Local builds and flavors: [build.md](build.md)
