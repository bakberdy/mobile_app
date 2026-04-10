# iOS local builds

This document describes how to build the app on a developer machine. CI secrets are not required locally; see [upload.md](upload.md) for TestFlight automation and GitHub Actions secrets.

---

## Flavors

The iOS targets mirror Android: `development`, `staging`, `production`.

| Flavor | Xcode scheme | Bundle ID |
|--------|--------------|-----------|
| `development` | `development` | `com.bakberdi.travelApp.development` |
| `staging` | `staging` | `com.bakberdi.travelApp.staging` |
| `production` | `production` | `com.bakberdi.travelApp` |

Shared schemes live under `ios/Runner.xcodeproj/xcshareddata/xcschemes/`. Per-flavor settings use `ios/Flutter/*-{development,staging,production}.xcconfig`.

---

## Prerequisites

- Xcode and CocoaPods installed.
- From the repository root: `flutter pub get`
- From `ios/`: run `pod install`

If CocoaPods fails with encoding errors, use a UTF-8 locale, for example:

```bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
cd ios && pod install
```

---

## Commands (repository root)

Run or debug (simulator or device):

```bash
flutter run --flavor development
flutter run --flavor staging
flutter run --flavor production
```

Release build for device without code signing (sanity check):

```bash
flutter build ios --flavor production --release --no-codesign
```

Use `staging` or `development` instead of `production` when needed.

---

## Signed archives and IPA

Local signed archives and IPAs use your Apple Developer account in Xcode (signing & capabilities). The tag-based pipeline builds production with Fastlane and the secrets listed in [upload.md](upload.md).
