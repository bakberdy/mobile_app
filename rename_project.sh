#!/usr/bin/env zsh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

read_pubspec_name() {
  grep -E '^name:' "$SCRIPT_DIR/pubspec.yaml" 2>/dev/null | head -1 | awk '{print $2}' | tr -d "'\"" | tr -d ' '
}

detect_ios_product_segment() {
  local f="$SCRIPT_DIR/ios/Flutter/Debug-production.xcconfig"
  if [[ ! -f "$f" ]]; then
    echo ""
    return
  fi
  local line
  line=$(grep -E '^PRODUCT_BUNDLE_IDENTIFIER=' "$f" | head -1 | cut -d= -f2-)
  echo "$line" | python3 -c "import re,sys; s=sys.stdin.read().strip(); m=re.match(r'com\\.bakberdi\\.([^.]+)', s); print(m.group(1) if m else '')"
}

read_display_name_main() {
  python3 -c "import plistlib; p=plistlib.load(open('$SCRIPT_DIR/ios/Runner/Info.plist','rb')); print(p.get('CFBundleDisplayName',''))"
}

usage() {
  echo "Usage:"
  echo "  $0 <new_package_name>"
  echo "  $0 <old_package_name> <new_package_name>"
  echo "  $0 <old_package_name> <new_package_name> <launcher_display_name>"
  echo ""
  echo "Examples:"
  echo "  $0 fitness_app"
  echo "  $0 mobile_app fitness_app"
  echo "  $0 mobile_app fitness_app \"Fitness Coach\""
  echo ""
  echo "Optional: DISPLAY_NAME=\"My App\" $0 fitness_app   (only with single-arg form)"
  echo ""
  echo "Renames Dart package imports, Android namespace/applicationId, Kotlin package path,"
  echo "iOS bundle id segment (com.bakberdi.*), xcconfigs, fastlane, web titles, and launcher display names."
}

if [[ -z "$1" ]]; then
  usage
  exit 1
fi

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

if [[ -n "$3" ]]; then
  OLD_PKG="$1"
  NEW_PKG="$2"
  NEW_MAIN="$3"
elif [[ -n "$2" ]]; then
  OLD_PKG="$1"
  NEW_PKG="$2"
  NEW_MAIN=""
else
  OLD_PKG="$(read_pubspec_name)"
  NEW_PKG="$1"
  NEW_MAIN="${DISPLAY_NAME:-}"
fi

if [[ -z "$OLD_PKG" ]]; then
  echo "Error: could not read package name from pubspec.yaml."
  exit 1
fi

if [[ "$OLD_PKG" == "$NEW_PKG" && -z "$NEW_MAIN" ]]; then
  echo "New package name is the same as the old name. Nothing to do."
  exit 0
fi

if ! echo "$NEW_PKG" | grep -qE '^[a-z][a-z0-9_]*$'; then
  echo "Error: new package name must match ^[a-z][a-z0-9_]*$ (Dart pubspec \"name\" rules)."
  exit 1
fi

if ! echo "$OLD_PKG" | grep -qE '^[a-z][a-z0-9_]*$'; then
  echo "Error: old package name must match ^[a-z][a-z0-9_]*$."
  exit 1
fi

OLD_CAMEL="$(detect_ios_product_segment)"
if [[ -z "$OLD_CAMEL" ]]; then
  OLD_CAMEL="$(python3 -c "import sys; s=sys.argv[1]; p=s.split('_'); print((p[0].lower()+''.join(x.title() for x in p[1:])) if p else s)" "$OLD_PKG")"
fi

NEW_CAMEL="$(python3 -c "import sys; s=sys.argv[1]; p=s.split('_'); print((p[0].lower()+''.join(x.title() for x in p[1:])) if p else s)" "$NEW_PKG")"

OLD_MAIN="$(read_display_name_main)"
if [[ -z "$NEW_MAIN" ]]; then
  NEW_MAIN="$(python3 -c "import sys; s=sys.argv[1]; print(' '.join(w.capitalize() for w in s.split('_')))" "$NEW_PKG")"
fi

if [[ "$OLD_PKG" == "$NEW_PKG" && "$OLD_MAIN" == "$NEW_MAIN" && "$OLD_CAMEL" == "$NEW_CAMEL" ]]; then
  echo "No effective changes (package, display, and iOS segment already match targets)."
  exit 0
fi

if [[ -n "$OLD_MAIN" && "$OLD_MAIN" == *" "* ]]; then
  OLD_STEM="${OLD_MAIN%% *}"
  NEW_STEM="${NEW_MAIN%% *}"
else
  OLD_STEM="$OLD_MAIN"
  NEW_STEM="$NEW_MAIN"
fi

echo "Package:  '$OLD_PKG' → '$NEW_PKG'"
echo "iOS id:   '$OLD_CAMEL' → '$NEW_CAMEL' (segment after com.bakberdi.)"
echo "Display:  '${OLD_MAIN:-<empty>}' → '$NEW_MAIN'"
echo "Working directory: $SCRIPT_DIR"
echo ""

export RENAME_ROOT="$SCRIPT_DIR"
export RENAME_OLD_PKG="$OLD_PKG"
export RENAME_NEW_PKG="$NEW_PKG"
export RENAME_OLD_CAMEL="$OLD_CAMEL"
export RENAME_NEW_CAMEL="$NEW_CAMEL"
export RENAME_OLD_MAIN="$OLD_MAIN"
export RENAME_NEW_MAIN="$NEW_MAIN"
export RENAME_OLD_STEM="$OLD_STEM"
export RENAME_NEW_STEM="$NEW_STEM"

python3 <<'PY'
import os
from pathlib import Path

root = Path(os.environ["RENAME_ROOT"])
old_pkg = os.environ["RENAME_OLD_PKG"]
new_pkg = os.environ["RENAME_NEW_PKG"]
old_camel = os.environ["RENAME_OLD_CAMEL"]
new_camel = os.environ["RENAME_NEW_CAMEL"]
old_main = os.environ.get("RENAME_OLD_MAIN", "")
new_main = os.environ.get("RENAME_NEW_MAIN", "")
old_stem = os.environ.get("RENAME_OLD_STEM", "")
new_stem = os.environ.get("RENAME_NEW_STEM", "")

exclude_dir = {
    ".git",
    ".dart_tool",
    "build",
    "Pods",
    ".symlinks",
    ".idea",
    ".gradle",
    "DerivedData",
}

suffixes = {
    ".dart",
    ".yaml",
    ".yml",
    ".json",
    ".gradle",
    ".kts",
    ".kt",
    ".swift",
    ".xml",
    ".plist",
    ".podspec",
    ".md",
    ".html",
    ".xcconfig",
    ".pbxproj",
    ".arb",
    ".properties",
    ".sh",
    ".code-workspace",
}

exact_names = {"Podfile", "Makefile", "CMakeLists.txt", "metadata.env"}

pairs = []

def add(o, n):
    if o and n and o != n and (o, n) not in pairs:
        pairs.append((o, n))

add(old_camel, new_camel)
add(old_pkg, new_pkg)

if old_main and new_main and old_main != new_main:
    disp = [
        (f"{old_stem} Staging", f"{new_stem} Staging"),
        (f"{old_stem} Dev", f"{new_stem} Dev"),
        (old_main, new_main),
    ]
    for o, n in disp:
        add(o, n)

pairs.sort(key=lambda x: len(x[0]), reverse=True)

def should_visit(path: Path) -> bool:
    for part in path.parts:
        if part in exclude_dir:
            return False
    return True

def is_text_candidate(path: Path) -> bool:
    if path.name == "rename_project.sh":
        return False
    if path.suffix.lower() in suffixes:
        return True
    if path.name in exact_names:
        return True
    return False

updated = []
for dirpath, dirnames, filenames in os.walk(root):
    dp = Path(dirpath)
    dirnames[:] = [d for d in dirnames if d not in exclude_dir and should_visit(dp / d)]
    if not should_visit(dp):
        continue
    for name in filenames:
        p = dp / name
        if not is_text_candidate(p):
            continue
        try:
            text = p.read_text(encoding="utf-8")
        except (UnicodeDecodeError, OSError):
            continue
        new_text = text
        for o, n in pairs:
            new_text = new_text.replace(o, n)
        if new_text != text:
            p.write_text(new_text, encoding="utf-8")
            updated.append(str(p.relative_to(root)))

print(f"Updated {len(updated)} file(s).")
for rel in sorted(updated):
    print(f"  {rel}")
PY

wb_old="$SCRIPT_DIR/lib/widgetbook/${OLD_PKG}_widgetbook.dart"
wb_new="$SCRIPT_DIR/lib/widgetbook/${NEW_PKG}_widgetbook.dart"
if [[ -f "$wb_old" && "$OLD_PKG" != "$NEW_PKG" ]]; then
  mv "$wb_old" "$wb_new"
  echo "  Renamed: lib/widgetbook/${NEW_PKG}_widgetbook.dart"
fi

if [[ "$OLD_PKG" != "$NEW_PKG" ]]; then
  kt="$(find "$SCRIPT_DIR/android/app/src/main/kotlin" -name MainActivity.kt 2>/dev/null | head -1)"
  if [[ -n "$kt" ]]; then
    kotlin_root="$SCRIPT_DIR/android/app/src/main/kotlin"
    pkg_line="$(grep -E '^package ' "$kt" | head -1 | awk '{print $2}')"
    if [[ -n "$pkg_line" ]]; then
      rel="${pkg_line//./\/}"
      target_dir="$kotlin_root/$rel"
      mkdir -p "$target_dir"
      if [[ "$(dirname "$kt")" != "$target_dir" ]]; then
        mv "$kt" "$target_dir/MainActivity.kt"
        echo "  Moved: android/app/src/main/kotlin/$rel/MainActivity.kt"
        old_dir="$(dirname "$kt")"
        while [[ "$old_dir" != "$target_dir" && "$old_dir" == "$kotlin_root/"* && "$old_dir" != "$kotlin_root" ]]; do
          rmdir "$old_dir" 2>/dev/null || break
          old_dir="$(dirname "$old_dir")"
        done
      fi
    fi
  fi
fi

echo ""
echo "Done."
echo "Next steps:"
echo "  1. Review changes with: git diff"
echo "  2. Run: flutter pub get"
echo "  3. Run: dart run build_runner build --delete-conflicting-outputs   (if codegen references the package name)"
echo "  4. Re-create iOS provisioning profiles and Play Console listings if bundle / applicationId changed."
