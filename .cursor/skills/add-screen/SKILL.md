---
name: add-screen
description: Creates a Flutter screen following the wrapper/content split pattern with BlocProvider, failure handling, localized strings, and project button/dialog components. Use when the user wants to add a screen, page, view, or UI for a feature. If a Figma URL is provided alongside the request, also apply the figma-implement-design skill for visual fidelity.
---

# Add Screen

## Confirm before writing

1. **Feature slug** and **screen name** (e.g. feature `booking`, screen `booking_list`)
2. **BLoC(s)** to provide and their initial event(s)
3. **Figma URL?** → If yes, load and follow the `figma-implement-design` skill in addition to this one

---

## File location

```
lib/src/features/<feature>/presentation/screens/<feature>_<name>_screen.dart
```

File must be prefixed with the feature name. Suffix is `_screen.dart` — never `_page.dart`.

---

## Screen skeleton

Every screen is **two widgets in one file**: a public wrapper and a private content widget.

```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:<package>/src/config/di/injection.dart';
import 'package:<package>/src/core/bloc/state_status/state_status.dart';
import 'package:<package>/src/core/error/error.dart';
import 'package:<package>/src/core/utils/extensions/context_x.dart';
import 'package:<package>/src/components/buttons/base_filled_button.dart';
import 'package:<package>/src/components/dialogs/base_snackbar.dart';
import 'package:<package>/src/components/dialogs/base_dialog.dart';
import 'package:<package>/src/features/<feature>/presentation/bloc/<topic>_bloc/<feature>_<topic>_bloc.dart';

@RoutePage()
class <Name>Screen extends StatelessWidget {
  const <Name>Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<<Topic>Bloc>()..add(const <Topic>Started()),
      child: const _<Name>ScreenContent(),
    );
  }
}

class _<Name>ScreenContent extends StatelessWidget {
  const _<Name>ScreenContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<<Topic>Bloc, <Topic>State>(
      listener: (context, state) {
        switch (state.status) {
          case ErrorStateStatus(:final failure):
            _handleFailure(context, failure);
          default:
            break;
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: Text(context.l10n.<titleKey>)),
        body: ...,
      ),
    );
  }

  void _handleFailure(BuildContext context, Failure failure) {
    final message = failure.message ?? failure.defaultMessage(context);
    switch (failure.type) {
      case FailureType.snackbar:
        BaseSnackbar.error(context, message: message);
      case FailureType.banner:
        BaseDialog.showBanner(context, message: message);
      case FailureType.alert:
        BaseDialog.showBasic(context,
          title: context.l10n.errorTitle,
          description: message,
          primaryLabel: context.l10n.ok,
          barrierDismissible: false,
        );
      case FailureType.fullScreenError:
        BaseDialog.showFullscreen(context,
          title: context.l10n.errorTitle,
          bodyText: message,
          primaryLabel: context.l10n.retry,
          onPrimary: () => context.read<<Topic>Bloc>().add(const <Topic>Started()),
          barrierDismissible: false,
        );
      case FailureType.inlineError:
        break;
      case FailureType.silent:
        break;
    }
  }
}
```

**Multiple BLoCs** → use `MultiBlocProvider`:
```dart
return MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => sl<ABloc>()..add(const AStarted())),
    BlocProvider(create: (_) => sl<BBloc>()..add(const BStarted())),
  ],
  child: const _<Name>ScreenContent(),
);
```

`_<Name>ScreenContent` can be `StatefulWidget` when local UI state is needed (animations, scroll controllers, focus nodes) — never for BLoC state or form values.

---

## Rules — enforced in every screen

### Strings
- ❌ `Text('Title')` — every user-visible string must use `context.l10n.<key>`
- ❌ `Text('Error occurred')` — use `failure.message ?? failure.defaultMessage(context)`

### Buttons
Never use raw Flutter buttons. Always use project components from `lib/src/components/buttons/`:

```dart
// ✅ GOOD
BaseFilledButton.primary(
  label: context.l10n.save,
  onPressed: () => context.read<<Topic>Bloc>().add(const <Topic>SavePressed()),
  loading: state.status.isLoading,
)
BaseIconButton.standard(icon: const Icon(Icons.close), onPressed: context.router.maybePop)

// ❌ BAD
FilledButton(onPressed: _onSave, child: Text('Save'))
ElevatedButton(...)
```

| Component | Factories | Use for |
|-----------|-----------|---------|
| `BaseFilledButton` | `.primary()`, `.secondary()` | Primary / secondary CTA |
| `BaseElevatedButton` | `.primary()`, `.secondary()` | Elevated actions |
| `BaseOutlinedButton` | `.primary()`, `.secondary()` | Outlined actions |
| `BaseTextButton` | `.primary()`, `.secondary()` | Inline text actions |
| `BaseIconButton` | `.standard()`, `.primary()`, `.secondary()` | Icon-only actions |

All accept `loading: bool` and `disabled: bool`.

### Dialogs and bottom sheets
```dart
// ❌ BAD
showDialog(context: context, builder: (_) => AlertDialog(...))
showModalBottomSheet(context: context, builder: (_) => ...)

// ✅ GOOD
BaseDialog.showBasic(context, title: ..., primaryLabel: ..., onPrimary: ...);
BaseBottomSheet.showSelect(context, title: ..., options: [...], selectedIndex: ...);
BaseBottomSheet.showList(context, title: ..., items: [...]);
```

### Form inputs — no TextEditingController
Input state lives in BLoC state via `FieldState<T>`. Read from state, dispatch on change:

```dart
BlocBuilder<<Topic>Bloc, <Topic>State>(
  builder: (context, state) => TextField(
    onChanged: (v) => context.read<<Topic>Bloc>().add(<Topic>FieldChanged(v)),
    decoration: InputDecoration(
      labelText: context.l10n.<fieldLabel>,
      errorText: state.<field>.isInvalid ? state.<field>.error : null,
    ),
  ),
)
```

### Null safety — no force unwraps
```dart
// ❌ BAD
final failure = someNullableFailure!;

// ✅ GOOD
final failure = someNullableFailure;
if (failure == null) return;
```

### Colors
```dart
// ❌ BAD — hardcoded
Color(0xFF123456), Colors.red

// ✅ GOOD
context.colorScheme.error, context.colorScheme.primary
```

### Imports
- ❌ No imports from any `data/` layer
- ❌ No imports from another feature's `presentation/` or BLoC directly

---

## Checklist

- [ ] File named `<feature>_<name>_screen.dart` — no `_page.dart`
- [ ] Wrapper: `@RoutePage()`, `StatelessWidget`, only provides BLoC(s)
- [ ] Content: private `_<Name>ScreenContent`, all UI lives here
- [ ] `BlocProvider.create` uses `sl<Bloc>()..add(InitialEvent())` — never in `initState`
- [ ] Failure handled via `BlocListener`/`BlocConsumer` by matching `ErrorStateStatus` / `state.status` and full `switch(failure.type)`
- [ ] `failure.message ?? failure.defaultMessage(context)` — no hardcoded fallback
- [ ] All visible strings use `context.l10n.<key>` — add keys to all 3 ARB files if new
- [ ] Only project buttons (`BaseFilledButton`, etc.) — no raw Flutter buttons
- [ ] No `showDialog` / `showModalBottomSheet` — use `BaseDialog` / `BaseBottomSheet`
- [ ] Form inputs via `FieldState` — no `TextEditingController`
- [ ] No force unwraps (`!`) without prior null check
- [ ] No hardcoded colors — use `context.colorScheme.*`
- [ ] No `data/` imports
