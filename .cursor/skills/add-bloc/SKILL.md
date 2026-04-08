---
name: add-bloc
description: Creates a BLoC (event, state, bloc files) for a feature's presentation layer using Freezed, injectable, optional bloc_concurrency when races are possible, and the wrapper/content screen split. Use when the user wants to add a BLoC, event, state, or presentation layer for a feature after the domain layer is ready.
---

# Add BLoC

## Confirm before writing

1. **Feature slug** and **topic** (e.g. feature `booking`, topic `booking_list`)
2. **Use cases** to inject (from the already-created domain layer)
3. **Events** to handle (name, payload)
4. **State fields** needed (domain entities to expose, whether any fields are form inputs)

---

## Directory layout

Reference: `user_config` uses `theme_bloc/`, `locale_bloc/`, etc.

```
lib/src/features/<feature>/presentation/bloc/<topic>_bloc/
  <topic>_bloc.dart           ← main file (parts + class)
  <topic>_event.dart          ← part of bloc
  <topic>_state.dart          ← part of bloc
  <topic>_bloc.freezed.dart   ← generated, never edit
```

---

## File 1 — `<topic>_bloc.dart`

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:<package>/src/core/bloc/field_state/field_state.dart';
import 'package:<package>/src/core/bloc/state_status/state_status.dart';
import 'package:<package>/src/core/error/error.dart';
import 'package:<package>/src/core/usecases/use_case.dart';
import 'package:<package>/src/features/<feature>/domain/usecases/<verb>_<noun>_use_case.dart';
// import 'package:bloc_concurrency/bloc_concurrency.dart'; // only if you use transformer: below

part '<topic>_event.dart';
part '<topic>_state.dart';
part '<topic>_bloc.freezed.dart';

@Injectable()
class <Topic>Bloc extends Bloc<<Topic>Event, <Topic>State> {
  final <Action>UseCase _<action>UseCase;

  <Topic>Bloc(this._<action>UseCase) : super(const <Topic>State()) {
    on<<Topic>Started>(_onStarted);
    // Race-prone handlers only — see presentation-bloc.mdc
    // on<<Topic>QueryChanged>(_onQueryChanged, transformer: restartable());
    // on<<Topic>ItemSaved>(_onItemSaved, transformer: sequential());
  }

  Future<void> _onStarted(<Topic>Started event, Emitter<<Topic>State> emit) async {
    emit(state.copyWith(status: StateStatus.loading()));

    final result = await _<action>UseCase(const NoParams());

    result.fold(
      (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
      (data) => emit(
        state.copyWith(
          status: StateStatus.success(),
          data: data,
        ),
      ),
    );
  }
}
```

**`bloc_concurrency` — add only when a race is plausible**

| Transformer | Use when |
|-------------|----------|
| `droppable()` | Same event can fire again before the previous async run finishes (refresh spam) |
| `sequential()` | Writes must not interleave |
| `restartable()` | Latest event wins (search, `ApiCancelToken` — see `cancel-token.mdc`) |

**Simple** BLoCs: async `on<>` **without** `transformer:` is fine. Synchronous handlers never need a transformer.

Import `bloc_concurrency` only in files that pass `transformer:` to at least one `on<...>()`.

---

## File 2 — `<topic>_event.dart`

```dart
part of '<topic>_bloc.dart';

@freezed
sealed class <Topic>Event with _$<Topic>Event {
  const factory <Topic>Event.started() = <Topic>Started;
  const factory <Topic>Event.refreshed() = <Topic>Refreshed;
  // const factory <Topic>Event.itemSaved(<Entity> item) = <Topic>ItemSaved;
}
```

Named constructor convention: `<Topic>Event.verbNoun(payload) = ConcreteClass`
- `.started()` → `<Topic>Started`
- `.itemSaved(item)` → `<Topic>ItemSaved`

---

## File 3 — `<topic>_state.dart`

```dart
part of '<topic>_bloc.dart';

@freezed
sealed class <Topic>State with _$<Topic>State {
  const factory <Topic>State({
    ReturnType? data,
    @Default(StateStatus.initial()) StateStatus status,
  }) = _<Topic>State;
}
```

**For features with form inputs** — use `FieldState<T>`, never `TextEditingController`:
```dart
@freezed
sealed class <Topic>State with _$<Topic>State {
  const factory <Topic>State({
    @Default(StateStatus.initial()) StateStatus status,
    @Default(FieldState(value: '')) FieldState<String> nameField,
    @Default(FieldState(value: '')) FieldState<String> emailField,
  }) = _<Topic>State;
}
```

**Inline validation errors** — map `FailureType.inlineError` to the specific `FieldState`, not to `StateStatus.error`:
```dart
result.fold(
  (failure) {
    if (failure.type == FailureType.inlineError) {
      emit(state.copyWith(
        nameField: state.nameField.copyWith(status: FieldStatus.invalid, error: failure.message),
      ));
    } else {
      emit(state.copyWith(status: StateStatus.error(failure)));
    }
  },
  (_) => emit(state.copyWith(status: StateStatus.success())),
);
```

---

## Allowed imports in BLoC files

| ✅ Allowed | ❌ Forbidden |
|-----------|------------|
| `flutter_bloc`; `bloc_concurrency` only if using `transformer:` | Any `data/` layer import |
| `freezed_annotation`, `injectable` | `Analytics.track(...)` |
| Own feature's `domain/` (usecases, entities) | Another feature's BLoC or presentation |
| `core/bloc/` (`StateStatus`, `FieldState`, `Failure`) | `dio`, `shared_preferences`, or any platform package |

**`build.yaml`** turns off Freezed **`from_json` / `to_json` / `map` / `when`**. Branch events and states with **`switch`** on concrete types; do not use **`.map`/`.when`** or Freezed JSON on BLoC types.

---

## After files are created

Run code generation:
```bash
dart run build_runner build -d
```

Verify `<topic>_bloc.freezed.dart` was generated. Fix any analyzer issues.

---

## Rule compliance checklist

- [ ] Extends `Bloc<Event, State>` — never `Cubit`
- [ ] `@Injectable()` — never `@LazySingleton` or `@Singleton`
- [ ] `bloc_concurrency` + `transformer:` only on handlers that can overlap; simple flows omit
- [ ] Events: `@freezed sealed class` with `part of` — no manual subclasses
- [ ] State uses `@Default(StateStatus.initial()) StateStatus status` — global errors use `StateStatus.error(Failure)`, not `String? errorMessage`
- [ ] Input fields use `FieldState<T>`, not `TextEditingController`
- [ ] `FailureType.inlineError` mapped to field, not `StateStatus.error`
- [ ] No `data/` imports, no `Analytics.track()`
- [ ] No Freezed **`.map`/`.when`** or JSON on event/state (per `build.yaml`)
- [ ] No unnecessary `bloc_concurrency` import on purely simple BLoCs
- [ ] BLoC lives under `presentation/bloc/<topic>_bloc/` with `<topic>_bloc.dart` / `_event` / `_state`
- [ ] `build_runner` ran and generated file exists
