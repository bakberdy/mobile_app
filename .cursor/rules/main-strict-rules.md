# Main Strict Rules — Architecture Overview

This project follows **Clean Architecture** with strict layer isolation. Detailed rules for each layer live in dedicated `.mdc` rule files:

| Rule file | Applies to |
|-----------|-----------|
| `domain-layer.mdc` | `lib/src/features/**/domain/**/*.dart` |
| `data-layer.mdc` | `lib/src/features/**/data/**/*.dart` |
| `model-entity-separation.mdc` | `lib/src/features/**/*.dart` |
| `presentation-layer.mdc` | `lib/src/features/**/presentation/**/*.dart` |
| `bloc-layer.mdc` | `lib/src/features/**/presentation/bloc*/**/*.dart` |
| `core.mdc` | `lib/src/core/**/*.dart` |
| `navigation.mdc` | `lib/src/**/*.dart` |
| `dependency-injection.mdc` | `lib/src/**/*.dart` |

---

## Quick reference — non-negotiable rules

### Architecture boundaries
- Domain has **zero** Flutter or data-layer imports
- Data layer imports only own feature's domain + core — **never** another feature's data layer
- Presentation and BLoC have **zero** data-layer imports — including models
- BLoC never calls `Analytics.track(...)` — only UseCases do

### Model vs Domain class
- Domain classes (`domain/entity/`) — `Equatable`, no Freezed, no JSON, **no `Entity` suffix**
  - ✅ `Route`, `RouteType` extends `Equatable` — ❌ `RouteEntity`, `@freezed class Route`
- Models (`data/models/`) — extend domain class, `@JsonSerializable`, no Freezed
  - `RouteModel extends Route` — model IS the domain class (no `toEntity()` needed)
  - `fromEntity()` named constructor lives inside the model (for write-back to API)
- BLoCs and UseCases use domain classes only — never Models

### Naming
- UseCase classes end with `UseCase` (not `Usecase`), files end with `_use_case.dart`
- All files inside a feature are prefixed with the feature name: `<feature_name>_<file>.dart`
- Screens: `_screen.dart` suffix, `Screen` class suffix, `@RoutePage()` annotation — ❌ never `_page.dart` / `Page`

### Navigation
- ❌ Never use `Navigator.of(context).push(...)` — always `context.router.*`
- All routes declared in `lib/src/config/router/app_router.dart`
- Navigation triggered from `BlocListener` in UI — never inside BLoC or UseCase
- Guards extend `AutoRouteGuard`, live in `lib/src/config/router/`

### BLoC
- Always `Bloc<Event, State>` — **never** `Cubit`
- Use `bloc_concurrency` transformers for async events
- Global errors use `StateStatus.error(Failure)` — never a raw `String? errorMessage` on state
- Input fields use `FieldState<T>` — never `TextEditingController`
- Screen = wrapper (`@RoutePage`, provides BLoC) + `_ScreenContent` (all UI) — both in one file
- `@RoutePage()` only on the wrapper — never on `_ScreenContent`
- `BlocProvider.create:` dispatches initial event — never in `initState` or `build`

### Failures
- Exceptions are caught in the **data** layer and converted to `Failure`
- `Failure` types are business logic — live in domain
- `inlineError` failures are mapped in BLoC to `FieldState.error` — not shown via snackbar/alert
- Failures are sent to analytics **only** inside UseCases

### Presentation
- **Zero** hardcoded texts — all strings in `app_<lang>.arb` and accessed via `context.l10n`
- **Zero** hardcoded colors — use `context.colorScheme.*`
- **No force unwrap** — never use `!` without a preceding `if (x == null) return` check
- Failure display: `snackbar` → `BaseSnackbar`, `alert` → `BaseDialog.showBasic(...)`, `fullScreenError` → `BaseDialog.showFullscreen(...)`, `banner` → `MaterialBanner`
- If `failure.message` is null → show localized default via `context.l10n`

### Dependency Injection
- `@Injectable()` → BLoC only (factory, new instance per screen)
- `@LazySingleton()` → everything else: UseCase, Repository impl, DataSource impl
- `@LazySingleton(as: Interface)` → when binding impl to its interface (repositories, data sources)
- External/platform deps → `@module abstract class AppModule` in `lib/src/config/di/app_module.dart`
- ❌ Never call `GetIt.instance.get<T>()` inside a class — constructor injection only
- ❌ Never inject by implementation — always by interface
- `BlocProvider` at screen level only — never deep inside widget tree

### Analytics
- Feature-specific event classes live in `domain/analytics/<feature_name>_events.dart`
- Event names/properties defined as named constructors — never inline strings
- `Analytics.track(...)` only in UseCase `call()` method
