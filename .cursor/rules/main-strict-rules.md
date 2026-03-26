# Main Strict Rules — Architecture Overview

This project follows **Clean Architecture** with strict layer isolation. Detailed rules for each layer live in dedicated `.mdc` rule files:

| Rule file | Applies to |
|-----------|-----------|
| `domain-layer.mdc` | `lib/src/features/**/domain/**/*.dart` |
| `data-layer.mdc` | `lib/src/features/**/data/**/*.dart` |
| `presentation-layer.mdc` | `lib/src/features/**/presentation/**/*.dart` |
| `bloc-layer.mdc` | `lib/src/features/**/presentation/bloc*/**/*.dart` |
| `core.mdc` | `lib/src/core/**/*.dart` |

---

## Quick reference — non-negotiable rules

### Architecture boundaries
- Domain has **zero** Flutter or data-layer imports
- Data layer imports only own feature's domain + core — **never** another feature's data layer
- Presentation and BLoC have **zero** data-layer imports
- BLoC never calls `Analytics.track(...)` — only UseCases do

### Naming
- UseCase classes end with `UseCase` (not `Usecase`), files end with `_use_case.dart`
- All files inside a feature are prefixed with the feature name: `<feature_name>_<file>.dart`

### BLoC
- Always `Bloc<Event, State>` — **never** `Cubit`
- Use `bloc_concurrency` transformers for async events
- State holds `Failure?` as a typed field — never a raw `String? errorMessage`
- Input fields use `FieldState<T>` — never `TextEditingController`

### Failures
- Exceptions are caught in the **data** layer and converted to `Failure`
- `Failure` types are business logic — live in domain
- `inlineError` failures are mapped in BLoC to `FieldState.error` — not shown via snackbar/alert
- Failures are sent to analytics **only** inside UseCases

### Presentation
- **Zero** hardcoded texts — all strings in `app_<lang>.arb` and accessed via `context.l10n`
- **Zero** hardcoded colors — use `context.colorScheme.*`
- Failure display: `snackbar` → `BaseSnackbar`, `alert` → `BaseDialog.showBasic(...)`, `fullScreenError` → `BaseDialog.showFullscreen(...)`, `banner` → `MaterialBanner`
- If `failure.message` is null → show localized default via `context.l10n`

### Analytics
- Feature-specific event classes live in `domain/analytics/<feature_name>_events.dart`
- Event names/properties defined as named constructors — never inline strings
- `Analytics.track(...)` only in UseCase `call()` method
