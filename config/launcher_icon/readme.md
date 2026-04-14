# Launcher icons

Use **1024×1024** PNGs as the master artwork. Paths are set per flavor in `flutter_launcher_icons-*.yaml` in this folder via `image_path` (paths are relative to the **project root**).

## Why a script

`flutter_launcher_icons` only runs **flavor-aware** generation when it finds files named `flutter_launcher_icons-<flavor>.yaml` in the **project root**, then writes:

- Android: `android/app/src/<flavor>/res/mipmap-*/ic_launcher.png` (alongside your `development` / `staging` / `production` product flavors)
- iOS: `AppIcon-<flavor>` asset catalogs and updates `ASSETCATALOG_COMPILER_APPICON_NAME` for matching Xcode configurations (for example `Debug-development` → `AppIcon-development`)

Configs kept under `config/launcher_icon/` are not discovered there. Symlinks in the root do not work either (the tool only treats regular files as flavor configs). This repo uses **hard links** from the root into this directory for the duration of one run.

## Generate all three flavors

From the project root:

```bash
bash config/launcher_icon/generate_icons.sh
```

Or from this directory:

```bash
bash generate_icons.sh
```

The script links the three YAML files at the repo root, runs `flutter pub get` and `dart run flutter_launcher_icons` once, then removes the root links. Your canonical configs stay only under `config/launcher_icon/`.

## Manual (not recommended)

Duplicating the YAML files at the project root or running `dart run flutter_launcher_icons -f config/launcher_icon/...` three times overwrites the same `main` / default `AppIcon` output; use the script above instead.
