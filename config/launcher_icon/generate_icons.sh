#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$ROOT"
cleanup() {
  rm -f flutter_launcher_icons-development.yaml flutter_launcher_icons-production.yaml
}
trap cleanup EXIT
ln -f "$SCRIPT_DIR/flutter_launcher_icons-development.yaml" flutter_launcher_icons-development.yaml
ln -f "$SCRIPT_DIR/flutter_launcher_icons-production.yaml" flutter_launcher_icons-production.yaml
flutter pub get
dart run flutter_launcher_icons
