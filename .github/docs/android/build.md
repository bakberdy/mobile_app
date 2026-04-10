# Android CI builds

This document describes GitHub Actions workflows under `.github/workflows/` that build release APKs for each flavor.

---

## 1. GitHub Actions secrets

Add secrets in the repository: **Settings → Secrets and variables → Actions → New repository secret**. Names are case-sensitive and must match exactly.

### 1.1 Build-time configuration (API URL and environment label)

These are injected at build time as Dart defines (`API_URL`, `ENVIRONMENT`). Use plain strings (no JSON wrapper).

| Secret | Required for | Format | Example (shape only) |
|--------|----------------|--------|----------------------|
| `DEVELOPMENT_API_URL` | `android-build-development` | HTTPS URL string | `https://api.dev.example.com` |
| `DEVELOPMENT_ENVIRONMENT` | `android-build-development` | Short label your app reads | `development` |
| `STAGING_API_URL` | `android-build-staging` | HTTPS URL string | `https://api.stage.example.com` |
| `STAGING_ENVIRONMENT` | `android-build-staging` | Short label | `staging` |
| `PRODUCTION_API_URL` | `android-build-production`, `android-release-on-tag` (build job) | HTTPS URL string | `https://api.example.com` |
| `PRODUCTION_ENVIRONMENT` | same as above | Short label | `production` |

**Rules**

- Values must be **non-empty**; the build workflows fail fast if a required secret is missing.
- URLs are typically `https://…` with no trailing slash unless your backend expects one.
- `ENVIRONMENT` should match whatever `lib/app_config.dart` (or your config layer) expects for that flavor.

### 1.2 Tag-based release automation (`android-release-on-tag`)

These drive a GitHub App that bumps `pubspec.yaml` on the default branch after a valid semver tag.

| Secret | Format | Notes |
|--------|--------|--------|
| `RELEASE_APP_ID` | Numeric GitHub App ID | From the app’s settings page. |
| `RELEASE_APP_PRIVATE_KEY` | PEM **or** base64 of PEM | Full `-----BEGIN … PRIVATE KEY-----` … `-----END…` block (newlines preserved), **or** the same key encoded as a single-line base64 string; the workflow accepts both. |

The **build** phase of that workflow reuses `android-build-production`, so **`PRODUCTION_API_URL`** and **`PRODUCTION_ENVIRONMENT`** must also be set.

---

## 2. Workflows overview

| Workflow file | When it runs | Produces |
|---------------|----------------|----------|
| `android-build-development.yml` | Manual (`workflow_dispatch`) or `workflow_call` | `app-development-release.apk` artifact |
| `android-build-staging.yml` | Manual or `workflow_call` | `app-staging-release.apk` artifact |
| `android-build-production.yml` | Manual, `workflow_call`, or called from tag release | `app-production-release.apk` artifact |
| `android-release-on-tag.yml` | Push of tag matching `v?MAJOR.MINOR.PATCH` | Bumps `pubspec` via bot, then production APK |
| `analyzer-check.yml` | Reusable only (`workflow_call`) | Static analysis (not covered in depth here) |

Production flavor **applicationId** is `com.bakberdi.mobile_app` (see `android/app/build.gradle.kts`).

---

## 3. Artifact names and APK paths

Version is read from `pubspec.yaml` (`version: <name>+<code>`, e.g. `1.2.6+27`).

| Flavor | Artifact name pattern | File inside artifact |
|--------|------------------------|----------------------|
| development | `android-development-release-<name>-<code>` | `app-development-release.apk` (paths preserved in zip) |
| staging | `android-staging-release-<name>-<code>` | `app-staging-release.apk` |
| production | `android-production-release-<name>-<code>` | `app-production-release.apk` |

Example: `version: 1.2.6+27` → production artifact name `android-production-release-1.2.6-27`.

---

## 4. Step-by-step: build a production APK in CI

1. Ensure **`PRODUCTION_API_URL`** and **`PRODUCTION_ENVIRONMENT`** exist under Actions secrets.
2. Set `pubspec.yaml` to the intended `version: name+code` (the `+` suffix is the Android `versionCode`).
3. Open **Actions → android-build-production → Run workflow**.
4. Pick the branch (usually `main` or your release branch) and start the run.
5. When the job finishes, open the run → **Artifacts** and download the production APK if needed.

**Alternative:** Push a tag that matches `android-release-on-tag` rules; the workflow commits the bumped version (if needed) and then runs the same production build with `secrets: inherit`.

---

## 5. Local parity (reference)

Local release builds use the same flavors; align `--dart-define=API_URL` and `ENVIRONMENT` with the values you store in secrets for that flavor. CI does not read `config/*.json` for these workflows; it uses secrets only.

---

## 6. Checklist summary

**Before any flavor build in Actions**

- [ ] Corresponding `*_API_URL` and `*_ENVIRONMENT` secrets set.

**Before tag release automation**

- [ ] `RELEASE_APP_ID`, `RELEASE_APP_PRIVATE_KEY`, `PRODUCTION_*` secrets set.
- [ ] GitHub App installed on the repo with contents write and bypass rules as documented in the workflow errors.
