---
name: flutter-feature-scaffold
description: Scaffolds a new Flutter feature module under lib/src/features with Clean Architecture layers (data, domain, presentation), injectable DI, dartz Either use cases, and Freezed BLoC. Use when the user asks to create a feature, module, slice, or to generate repository/use case/BLoC files matching the existing user_config-style layout.
---

# Flutter feature scaffold

## Before writing code

1. Read **`pubspec.yaml`** → use `package:<name>/...` for all imports (`<name>` is the `name` field).
2. If present, read **[`.cursor/rules/feature-structure-user-config.mdc`](../../rules/feature-structure-user-config.mdc)** and mirror **[`lib/src/features/user_config/`](../../../lib/src/features/user_config/)** for **class patterns** (BLoC, use cases, DI). **New** folder segments must be **plural** (`datasources/`, `repositories/`, `entities/`, `blocs/`, `themes/`).
3. Confirm with the user (or infer from context): **feature slug** in `snake_case` (e.g. `booking`), primary **BLoC topic** (e.g. `booking_list`), and whether they need **local** data source, **remote**, or both.

## Directory tree to create

Under `lib/src/features/<feature_snake>/`:

| Path | Purpose |
|------|--------|
| `<feature>_consts.dart` | Optional keys / shared strings |
| `data/datasources/` | Abstract + `*Impl`; `@Singleton(as: AbstractType)` |
| `data/repositories/` | `*RepositoryImpl` → `@Singleton(as: DomainRepository)` |
| `data/models/` | Optional DTOs with `json_serializable` |
| `domain/entities/` | Entities (e.g. `equatable`) |
| `domain/repositories/` | Abstract `*Repository` |
| `domain/usecases/` | `*Usecase extends UseCase<...>` + `*Params` when needed |
| `presentation/blocs/<topic>_bloc/` | `*_bloc.dart` + `*_event.dart` + `*_state.dart` + generated `*.freezed.dart` |
| `presentation/screens/` | Routed full UI; widget types **`Screen`** suffix (e.g. `BookingDetailScreen`), files `*_screen.dart`—no `Page` / `pages/` |
| `presentation/themes/` | Optional scoped theme helpers |
| `presentation/widgets/` | Feature-only UI pieces |

Do not skip **domain** or place repository impl next to the abstract repository.

## Class and file naming

- **Feature slug:** `booking` → prefix types: `BookingRepository`, `BookingRepositoryImpl`, `BookingRemoteDataSource`, `BookingListBloc`.
- **Routed views:** `SomethingScreen` + `something_screen.dart` under `presentation/screens/`. Never `SomethingPage`, `*_page.dart`, or a `presentation/pages/` folder for new work.
- **Files:** `snake_case.dart`. BLoC folder: `presentation/blocs/booking_list/booking_list_bloc.dart`, etc.
- **Use cases:** `GetBookingUsecase`, `GetBookingUsecaseParams` (if params needed); `@LazySingleton()`.
- **Repository impl / datasources:** `@Singleton(as: InterfaceType)`.

## Layer rules (quick)

- **Repository (domain):** abstract class; methods return `FutureEither<...>` from `lib/src/core/utils/typedef.dart`.
- **Use case:** `extends UseCase<T, Params>` from `lib/src/core/usecases/usecase.dart`; call repository only; use `NoParams` when there are no inputs.
- **BLoC:** `@Injectable()`; `part` event + state + `*_bloc.freezed.dart`; events/states `@freezed` + `sealed class`; state includes `@Default(StateStatus.initial) StateStatus status` and `String? errorMessage` where appropriate; fold failures with `Failure` from `lib/src/core/error/error.dart`.
- **Presentation:** widgets call BLoC/`context.read`—no direct `LocalStorage` or raw HTTP in widgets.

## BLoC skeleton (pattern)

Main file is `part of` aggregator **or** single file imports parts—match **user_config** (`theme_bloc` / `locale_bloc`):

- `*_bloc.dart`: imports, `part '..._event.dart';` `part '..._state.dart';` `part '..._bloc.freezed.dart';`, `@Injectable()` class extending `Bloc<Event, State>`.
- `*_event.dart`: `part of '..._bloc.dart';` + `@freezed sealed class ...Event`.
- `*_state.dart`: `part of '..._bloc.dart';` + `@freezed sealed class ...State` with `StateStatus`.

## After files exist

Run code generation (injectable + freezed + json_serializable if added):

```bash
dart run build_runner build -d
```

Fix any analyzer issues, then ensure new types appear in **`lib/src/config/di/injection.config.dart`** after a successful build.

## Checklist (agent)

- [ ] Tree matches table; package imports use `package:<pubspec_name>/src/...`
- [ ] New routed UI uses `*Screen` / `*_screen.dart` in `presentation/screens/` (no `Page` naming)
- [ ] Abstract repository in `domain/repositories/`, impl in `data/repositories/`
- [ ] Use cases depend only on repository interface
- [ ] BLoC depends on use cases, not datasource
- [ ] `build_runner` run and analyzer clean
