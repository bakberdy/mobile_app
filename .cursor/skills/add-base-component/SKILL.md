---
name: add-base-component
description: Creates a reusable shared UI component in lib/src/components/ following the project's private-constructor + static-factory pattern, then registers it in presentation-components.mdc. Use when a widget or utility will be used in multiple features, when the user says "make this reusable", "extract to a component", "create a shared component", or "add a base widget".
---

# Add Base Component

## Confirm before writing

1. **Component name** (e.g. `StatusBadge`, `AvatarImage`)
2. **Type** — renderable widget or static utility?
   - **Widget** → renders UI, has variants, `loading`/`disabled` if interactive (follow button pattern)
   - **Utility** → static methods only, no `build()` (follow `BaseSnackbar` / `BaseDialog` pattern)
3. **Variants** needed (e.g. `primary`, `secondary`, `success`, `error`)
4. **File location** — `buttons/`, `dialogs/`, or create a new subfolder under `lib/src/components/`

---

## Pattern A — Widget component (renders UI)

File: `lib/src/components/<subfolder>/base_<name>.dart`

```dart
import 'package:flutter/material.dart';
import 'package:<package>/src/core/utils/extensions/context_x.dart';
// import base_button_progress.dart if loading indicator needed

class Base<Name> extends StatelessWidget {
  const Base<Name>._({
    super.key,
    required _Base<Name>Variant variant,
    required this.someParam,
    this.disabled = false,
    this.loading = false,
  }) : _variant = variant;

  factory Base<Name>.primary({
    Key? key,
    required SomeType someParam,
    bool disabled = false,
    bool loading = false,
  }) => Base<Name>._(
        key: key,
        variant: _Base<Name>Variant.primary,
        someParam: someParam,
        disabled: disabled,
        loading: loading,
      );

  factory Base<Name>.secondary({
    Key? key,
    required SomeType someParam,
    bool disabled = false,
    bool loading = false,
  }) => Base<Name>._(
        key: key,
        variant: _Base<Name>Variant.secondary,
        someParam: someParam,
        disabled: disabled,
        loading: loading,
      );

  final _Base<Name>Variant _variant;
  final SomeType someParam;
  final bool disabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    // Use context.colorScheme.* — never hardcode colors
    return ...;
  }
}

enum _Base<Name>Variant { primary, secondary }
```

**Rules for widget components:**
- Private constructor `const ClassName._({...})` — never expose publicly
- One `factory` per variant — callers never use `_` constructor
- `_VariantEnum` defined private at the **bottom** of the file
- `disabled` and `loading` for any interactive component
- Colors only via `context.colorScheme.*` or `context.baseThemeX.*` — no `Colors.*`, no hex
- For loading spinners: use `baseButtonProgressIndicator(color)` from `lib/src/components/buttons/base_button_progress.dart`
- `StatelessWidget` unless local animation state is needed; use `StatefulWidget` only for animations/focus

---

## Pattern B — Static utility component

File: `lib/src/components/<subfolder>/base_<name>.dart`

```dart
import 'package:flutter/material.dart';
import 'package:<package>/src/core/utils/extensions/context_x.dart';

class Base<Name> {
  Base<Name>._(); // prevents instantiation

  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    // implementation
  }

  static void hide(BuildContext context) { ... }
}
```

**Rules for utility components:**
- `ClassName._()` private constructor — no `const`, no fields
- All methods are `static`
- Never instantiate this class — only call static methods

---

## After creating the file

Update `presentation-components.mdc` to document the new component so the agent knows to use it instead of raw Flutter equivalents:

```markdown
## <Name> component

Use `Base<Name>` from `lib/src/components/<subfolder>/base_<name>.dart`.
Never use raw Flutter `<EquivalentWidget>`.

| Factory | Use for |
|---------|---------|
| `Base<Name>.primary(...)` | ... |
| `Base<Name>.secondary(...)` | ... |
```

---

## Import in feature files

```dart
import 'package:<package>/src/components/<subfolder>/base_<name>.dart';
```

Never import from another feature's `presentation/` directly — shared components live in `lib/src/components/` precisely to avoid this.

---

## Checklist

- [ ] File: `lib/src/components/<subfolder>/base_<name>.dart`, prefixed `base_`
- [ ] Widget: private `._()` constructor, public factory per variant
- [ ] Widget: `_VariantEnum` declared private at bottom of file
- [ ] Widget: `disabled` + `loading` params for interactive components
- [ ] Utility: `ClassName._()` only, all methods static
- [ ] No hardcoded colors — only `context.colorScheme.*` or `context.baseThemeX.*`
- [ ] `presentation-components.mdc` updated with usage docs for the new component
