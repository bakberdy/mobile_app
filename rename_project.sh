#!/usr/bin/env zsh

# Usage:
#   ./rename_project.sh <new_name>                  (old name defaults to "travel_app")
#   ./rename_project.sh <old_name> <new_name>        (explicit old and new names)
#
# Examples:
#   ./rename_project.sh my_new_app
#   ./rename_project.sh my_new_app travel_app        (rename back)

set -e

if [[ -z "$1" ]]; then
  echo "Error: at least one argument is required."
  echo "Usage: $0 <new_name>"
  echo "       $0 <old_name> <new_name>"
  exit 1
fi

if [[ -n "$2" ]]; then
  OLD_NAME="$1"
  NEW_NAME="$2"
else
  OLD_NAME="travel_app"
  NEW_NAME="$1"
fi

if [[ "$OLD_NAME" == "$NEW_NAME" ]]; then
  echo "New name is the same as the old name. Nothing to do."
  exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Renaming project: '$OLD_NAME' → '$NEW_NAME'"
echo "Working directory: $SCRIPT_DIR"
echo ""

# Count total matches before making changes
TOTAL=$(grep -rl "$OLD_NAME" \
  --include="*.dart" \
  --include="*.yaml" \
  --include="*.json" \
  --include="*.gradle" \
  --include="*.kt" \
  --include="*.swift" \
  --include="*.xml" \
  --include="*.plist" \
  --include="*.podspec" \
  --include="*.md" \
  "$SCRIPT_DIR" 2>/dev/null | grep -v "rename_project.sh" | wc -l | tr -d ' ')

echo "Found $TOTAL file(s) containing '$OLD_NAME'"
echo ""

# Perform the replacement
grep -rl "$OLD_NAME" \
  --include="*.dart" \
  --include="*.yaml" \
  --include="*.json" \
  --include="*.gradle" \
  --include="*.kt" \
  --include="*.swift" \
  --include="*.xml" \
  --include="*.plist" \
  --include="*.podspec" \
  --include="*.md" \
  "$SCRIPT_DIR" 2>/dev/null \
  | grep -v "rename_project.sh" \
  | while read -r file; do
      LC_ALL=C sed -i '' "s/$OLD_NAME/$NEW_NAME/g" "$file"
      echo "  Updated: ${file#$SCRIPT_DIR/}"
    done

echo ""
echo "Done. All occurrences of '$OLD_NAME' replaced with '$NEW_NAME'."
echo ""
echo "Next steps:"
echo "  1. Review changes with: git diff"
echo "  2. Run: flutter pub get"
echo "  3. If you renamed the project directory itself, update android/app/build.gradle applicationId and iOS bundle identifier manually."