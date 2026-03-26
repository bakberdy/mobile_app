---
name: add-localization-key
description: Adds a new localization key to all three ARB files (en, ru, kk) in lib/src/core/language/l10n/ and runs flutter gen-l10n to regenerate AppLocalizations. Use when the user wants to add a translation key, localization string, l10n entry, or ARB key.
---

# Add Localization Key

## ARB file locations

| Locale | File |
|--------|------|
| English (template) | `lib/src/core/language/l10n/app_en.arb` |
| Russian | `lib/src/core/language/l10n/app_ru.arb` |
| Kazakh | `lib/src/core/language/l10n/app_kk.arb` |

The template is `app_en.arb` (defined in `l10n.yaml`). Generated output goes to `lib/src/core/language/generated/`.

## Steps

1. **Confirm** the key name (`camelCase`) and translations for all 3 locales. If the user provides only the key and English value, ask for ru and kk before proceeding — do not leave placeholders.

2. **Edit all three ARB files** — insert the new key in **alphabetical order** by key name. Read the existing keys, find the correct position (case-insensitive sort), and insert there. Do not append blindly to the end.

3. **Regenerate** the `AppLocalizations` class:
   ```bash
   flutter gen-l10n
   ```

4. **Verify** the new getter appears in `lib/src/core/language/generated/app_localizations.dart`.

## ARB format rules

- Simple string (no parameters):
  ```json
  "myKey": "My value"
  ```
- String with a placeholder:
  ```json
  "welcomeUser": "Welcome, {name}!",
  "@welcomeUser": {
    "placeholders": {
      "name": { "type": "String" }
    }
  }
  ```
- The `@metadata` block is required only when placeholders are used.
- No trailing commas on the last entry before `}`.

## Usage in code

Access via `context.l10n.<key>` (never call `AppLocalizations.of(context)` directly):

```dart
Text(context.l10n.myKey)
```

## Checklist

- [ ] Key added to all 3 ARB files (en, ru, kk)
- [ ] No trailing comma on the last key in each file
- [ ] `flutter gen-l10n` ran successfully
- [ ] Getter visible in `app_localizations.dart`
