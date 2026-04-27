# Android CI/CD (step by step)

The same upload keystore is used both locally and in CI. Set up local first; CI just packages the same artifacts as secrets.

---

# Part A — Local builds

Use this path when you build a release AAB on your machine and either drag-drop it into Play Console yourself, or push it via your own CLI. This is also the fallback when CI is broken.

> **Where to run the commands:** Step A1 can be run from anywhere (it uses absolute paths). Steps **A2, A3, and A4 must be run from the repo root** (`cd /Users/bakberdi.yessentay/Documents/personal/projects/mobile_app`) — they use paths relative to the project, like `android/key.<flavor>.properties`, `config/run/...`, and `build/app/outputs/...`.

## Step A1 — Generate the upload keystore (one per flavor)

> Run from: **anywhere** (paths are absolute).

Each flavor gets its **own** upload keystore (mirror of iOS's per-flavor provisioning profiles). Generate once and store off-repo. The commands below put each keystore in `~/keys/mobile-app/<flavor>/upload.jks`. `keytool` will prompt for store password, key password (just press Enter to reuse the store password), and a Distinguished Name.

> **Already shipped via CI?** The keystore Play registered as your upload key is the **only** one that can sign future uploads for that app. Reuse the same `.jks`, do **not** regenerate — only run the command for flavors that don't have a keystore yet.

#### production

```bash
mkdir -p ~/keys/mobile-app/production
keytool -genkey -v \
  -keystore ~/keys/mobile-app/production/upload.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

#### development

```bash
mkdir -p ~/keys/mobile-app/development
keytool -genkey -v \
  -keystore ~/keys/mobile-app/development/upload.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

Verify any keystore:

```bash
keytool -list -v -keystore ~/keys/mobile-app/production/upload.jks -storepass '<store password>'
```

## Step A2 — Create `android/key.<flavor>.properties` (one per flavor)

> Run from: **repo root** (the `cat > android/key.<flavor>.properties` blocks write to relative paths).

`build.gradle.kts` resolves signing in this order, so you can keep all three files on disk simultaneously and `flutter build appbundle --flavor <flavor>` automatically picks the right one — **no swapping needed**:

1. `android/key.<flavor>.properties` — flavor-specific signing config (preferred)
2. `android/key.properties` — shared fallback for any flavor without its own file
3. Neither — falls back to the debug keystore so `flutter run --release` still works

All three patterns are gitignored (`key.properties`, `key.*.properties`, plus `**/*.jks` / `**/*.keystore`).

| Key | Meaning |
|-----|---------|
| `storeFile` | Path to the upload keystore (`.jks`) — absolute, or relative to `android/app/` |
| `storePassword` | Keystore (store) password |
| `keyAlias` | Key alias inside the keystore (the commands in A1 use `upload`) |
| `keyPassword` | Key password (often equal to `storePassword`) |

**Replace your home dir, store password, and key password before running.** Run only the flavors you ship.

#### production

```bash
cat > android/key.production.properties <<EOF
storeFile=/Users/bakberdi.yessentay/keys/mobile-app/production/upload.jks
storePassword=<store password>
keyAlias=upload
keyPassword=<key password>
EOF
```

#### development

```bash
cat > android/key.development.properties <<EOF
storeFile=/Users/bakberdi.yessentay/keys/mobile-app/development/upload.jks
storePassword=<store password>
keyAlias=upload
keyPassword=<key password>
EOF
```

## Step A3 — Build the AAB locally

> Run from: **repo root**.

Bump `pubspec.yaml` first (`version: <name>+<buildNumber>`). The `buildNumber` (the part after `+`) must be **strictly greater** than the highest value Play has ever seen for that app, or Play rejects the upload.

#### production

```bash
flutter clean && flutter pub get
flutter build appbundle --release --flavor production \
  --dart-define-from-file=config/run/config.production.json
# Output: build/app/outputs/bundle/productionRelease/app-production-release.aab
```

#### development

```bash
flutter clean && flutter pub get
flutter build appbundle --release --flavor development \
  --dart-define-from-file=config/run/config.development.json
# Output: build/app/outputs/bundle/developmentRelease/app-development-release.aab
```

## Step A4 — Upload the AAB

> Run from: **repo root** (the `--aab build/app/outputs/...` paths are relative to it).

Two paths — pick whichever you prefer.

**Path 1 — Drag-drop in Play Console (simplest, no extra setup):**

Play Console → the flavor's app → **Testing → Internal testing → Create new release** → drag the `.aab` in → **Save → Review → Roll out**.

**Path 2 — CLI via service account.** Requires the `play-service-account.json` file from [Step B2](#step-b2--google-play-api-service-account-play-service-accountjson) saved locally (e.g. `~/keys/mobile-app/play-service-account.json`) and Fastlane installed (`gem install fastlane`). The same JSON file is reused by CI — store it once and you're done.

#### production

```bash
fastlane supply \
  --aab build/app/outputs/bundle/productionRelease/app-production-release.aab \
  --package_name com.bakberdi.mobile_app \
  --track internal \
  --json_key ~/keys/mobile-app/play-service-account.json \
  --skip_upload_metadata true \
  --skip_upload_changelogs true \
  --skip_upload_images true \
  --skip_upload_screenshots true
```

#### development

```bash
fastlane supply \
  --aab build/app/outputs/bundle/developmentRelease/app-development-release.aab \
  --package_name com.bakberdi.mobile_app.development \
  --track internal \
  --json_key ~/keys/mobile-app/play-service-account.json \
  --skip_upload_metadata true \
  --skip_upload_changelogs true \
  --skip_upload_images true \
  --skip_upload_screenshots true
```

The Play Console app must already exist for the chosen flavor — see Step B1 below.

---

# Part B — CI/CD on GitHub Actions

Set up everything in Part A first (you'll reuse the same keystore here). Then proceed.

## Step B1 — Play Console app per flavor

Each Flutter flavor uploads to a **separate** Play Console app, because each flavor has a distinct `applicationId`.

| Flutter flavor | Play `packageName` |
|----------------|--------------------|
| `production` | `com.bakberdi.mobile_app` |
| `development` | `com.bakberdi.mobile_app.development` |

For each app:

1. **Create app** in Play Console with the matching `packageName`.
2. Complete the **App content** wizard (privacy policy, target audience, ads, data safety, etc.). You usually need at least one upload to the **internal** track before later API uploads behave normally; the first AAB can come from Step A4 or from the CI workflow.
3. Enable **Play App Signing** (recommended). Play stores the actual signing key; you only protect the upload key from Step A1.
4. Confirm the service account from Step B2 has access on this app.

## Step B2 — Google Play API service account (`play-service-account.json`)

This single JSON key authenticates uploads to Play. It's reused by both **local Fastlane uploads** (Step A4 Path 2) and **CI** (Step B3.2). Create it once. One service account is enough — it can manage all three per-flavor apps.

> **Treat this file like a password.** Anyone with it can publish to your Play apps. Store it off-repo (`~/keys/mobile-app/...`), `chmod 600`, never commit it.

### B2.1 Create the service account in Google Cloud

1. Open **[Google Cloud Console](https://console.cloud.google.com/)** and select (or create) any project — it just hosts the service account.
2. **APIs & Services → Library** → search **"Google Play Android Developer API"** → **Enable**.
3. **IAM & Admin → Service Accounts → Create service account**.
   - **Name:** something memorable, e.g. `mobile-app-play-uploader`.
   - **Grant this service account access to project:** leave blank (Play access is granted in B2.2, not here).
   - Click **Done**.
4. Open the new service account → **Keys** tab → **Add key → Create new key → JSON → Create**. Your browser downloads `<project>-<hash>.json`.
5. Rename and store off-repo:

```bash
mkdir -p ~/keys/mobile-app
mv ~/Downloads/<downloaded-name>.json ~/keys/mobile-app/play-service-account.json
chmod 600 ~/keys/mobile-app/play-service-account.json
```

### B2.2 Link the project to Play Console and grant access

The key now exists in Google Cloud, but Play doesn't know about it yet.

1. **Play Console → Setup → API access**.
2. **Link Google Cloud project** → choose the project from B2.1 (one-time per Play developer account; if it's already linked, skip).
3. Under **Service accounts**, find the account from B2.1 (it auto-appears once the project is linked) → **Manage Play Console permissions**.
4. **App permissions** tab → **Add app** → add **all flavor apps you ship** (`com.bakberdi.mobile_app`, `com.bakberdi.mobile_app.development`). The apps must already exist (Step B1).
5. **Account permissions** tab → enable at minimum:
   - **View app information and download bulk reports** (read access)
   - **Manage testing tracks and edit testers**
   - **Release apps to testing tracks**
   - Add **Release to production, exclude devices, and use Play app signing** only if this account will also push to production. Internal/alpha/beta tracks don't need it.
6. **Invite user → Send invite**. (No email is sent for service accounts — access is immediate.)

### B2.3 Smoke-test the key locally

Before wiring it into CI, confirm Fastlane can authenticate:

```bash
fastlane run validate_play_store_json_key \
  json_key:~/keys/mobile-app/play-service-account.json
```

Expected output: `Successfully established connection to Google Play Store`. If you see `401/403`, recheck **B2.2 step 5** (account permissions) and that the **app exists in Play Console** (Step B1).

### B2.4 Where this file is consumed

| Used by | How |
|---------|-----|
| Local Fastlane (Step A4 Path 2) | `--json_key ~/keys/mobile-app/play-service-account.json` |
| GitHub Actions (Step B3.2) | Paste the full file content (`{ ... }`) into the `PLAY_STORE_SERVICE_ACCOUNT_JSON` repo secret |

## Step B3 — GitHub Actions secrets

**Repo → Settings → Secrets and variables → Actions → New repository secret.**

### B3.1 Per-flavor signing (one set per flavor you ship)

Replace `<FLAVOR>` with `DEVELOPMENT` or `PRODUCTION`.

| Secret | Value |
|--------|-------|
| `ANDROID_KEYSTORE_BASE64_<FLAVOR>` | Base64 of the upload `.jks` from Step A1 (see commands below) |
| `ANDROID_KEYSTORE_PASSWORD_<FLAVOR>` | Same `storePassword` you used in `key.<flavor>.properties` |
| `ANDROID_KEY_ALIAS_<FLAVOR>` | Same `keyAlias` |
| `ANDROID_KEY_PASSWORD_<FLAVOR>` | Same `keyPassword` |

**Base64 the keystore (macOS, run from anywhere — adjust path):**

```bash
# Production keystore → secret ANDROID_KEYSTORE_BASE64_PRODUCTION
base64 -i ~/keys/mobile-app/production/upload.jks | tr -d '\n' | pbcopy

# Development keystore → secret ANDROID_KEYSTORE_BASE64_DEVELOPMENT
base64 -i ~/keys/mobile-app/development/upload.jks | tr -d '\n' | pbcopy
```

On Linux: `base64 -w0 upload.jks | xclip -selection clipboard` (or `wl-copy`).

Sanity-check a base64 secret by reversing it locally:

```bash
echo "<paste-secret>" | base64 -d > /tmp/check.jks
keytool -list -v -keystore /tmp/check.jks -storepass "<your store password>"
```

If the alias prints, the secret value will work in CI.

### B3.2 Google Play API

| Secret | Value |
|--------|-------|
| `PLAY_STORE_SERVICE_ACCOUNT_JSON` | Full service account JSON from Step B2 (plaintext, including the surrounding `{ ... }`) |

### B3.3 Build config (flavor-scoped — same as iOS)

Same JSON keys as `config/run/config.example.json` (`API_URL`, `ENVIRONMENT`, …). **Secret name = `<FLAVOR>_<KEY>`** with **FLAVOR** uppercase: `DEVELOPMENT` | `PRODUCTION`. Local builds still read `config/run/config.<flavor>.json`; CI passes `--dart-define` from these secrets.

| Secret | JSON field in that flavor's `config.*.json` |
|--------|---------------------------------------------|
| `DEVELOPMENT_API_URL` | `API_URL` |
| `DEVELOPMENT_ENVIRONMENT` | `ENVIRONMENT` |
| `PRODUCTION_API_URL` | `API_URL` |
| `PRODUCTION_ENVIRONMENT` | `ENVIRONMENT` |

For a given workflow run, the workflow `inputs.flavor` must have its keystore quartet (B3.1) **and** its build-config pair (B3.3), plus the shared Play row (B3.2). Tag-based release uses the **flavor in the tag prefix** (see Step B4).

### B3.4 Tag-based release automation (shared with iOS)

These drive the GitHub App that bumps `pubspec.yaml` on the default branch after a valid release tag.

| Secret | Format |
|--------|--------|
| `RELEASE_APP_ID` | Numeric GitHub App ID |
| `RELEASE_APP_PRIVATE_KEY` | PEM **or** base64 of PEM |

The App needs **Repository permissions → Contents = Read and write**, must be **installed** on this repo, and (if branch protection / rulesets are on the default branch) must be in the bypass list as **"Always allow"**.

## Step B4 — What CI runs and how

- **Workflow:** `.github/workflows/android-upload-to-play.yml` (reusable). It checks out the chosen `ref`, validates secrets per flavor, decodes the keystore from base64 to `${RUNNER_TEMP}/upload.jks`, writes `android/key.<flavor>.properties` with that path so Gradle picks the matching per-flavor signing config, runs `flutter build appbundle --release --flavor <flavor> --build-number=${GITHUB_RUN_ID} --dart-define=API_URL=... --dart-define=ENVIRONMENT=...`, then uploads the AAB via `r0adkll/upload-google-play@v1`.
- **Inputs:**
  - `flavor` — `development` | `production` (default `production`)
  - `track` — `internal` | `alpha` | `beta` | `production` (default `internal`)
  - `ref` — optional Git ref/SHA to check out (defaults to event ref)
- **`packageName`** is derived from `flavor` automatically (see Step B1 table).
- **Tag releases:** `.github/workflows/release-on-tag.yml` triggers on `release: published`, validates the tag must be `development-MAJOR.MINOR.PATCH` or `production-MAJOR.MINOR.PATCH`, bumps `pubspec.yaml`, then calls this workflow with `flavor: <prefix>` and `track: internal`. The bumped commit's SHA is passed as `ref` so the AAB is built from the version-bumped source, not the original tag commit.
- **Artifact:** on success, the AAB is uploaded as `android-<flavor>-aab-<name>-<code>` (also goes to Play in the same run).
- **Other flavors / other tracks in CI:** open **Actions → android-upload-to-play → Run workflow**, pick `flavor` and `track`. Only the secrets for that flavor + the shared Play row need to be filled.

---

## Reference (quick)

| Flutter flavor | applicationId / Play `packageName` | Config JSON (local / `dart-define-from-file`) |
|----------------|-------------------------------------|-----------------------------------------------|
| `development` | `com.bakberdi.mobile_app.development` | `config/run/config.development.json` |
| `production` | `com.bakberdi.mobile_app` | `config/run/config.production.json` |

| Output / artifact | Path |
|--------|------|
| Release AAB | `build/app/outputs/bundle/<flavor>Release/app-<flavor>-release.aab` |
| Decoded upload keystore in CI | `${RUNNER_TEMP}/upload.jks` |
| Generated signing config in CI | `android/key.<flavor>.properties` (CI-written; gitignored) |

| Tag prefix | Triggers flavor |
|------------|------------------|
| `production-MAJOR.MINOR.PATCH` | `production` |
| `development-MAJOR.MINOR.PATCH` | `development` |

**Dart / compile-time defines:** `API_URL` and `ENVIRONMENT` come from `lib/app_config.dart`. **Local:** `config/run/*.json`. **CI:** secrets `<FLAVOR>_<KEY>` (see Step B3.3). New key: add to `config.example.json` + `String.fromEnvironment(...)` in Dart, then add `DEVELOPMENT_NEWKEY` and `PRODUCTION_NEWKEY` in GitHub Actions secrets and add `--dart-define=NEWKEY="$NEWKEY"` to the `Build AAB` step in `.github/workflows/android-upload-to-play.yml` (and a matching `<FLAVOR>_NEWKEY` env entry).

**iOS CI:** [.github/docs/ios.md](ios.md)
