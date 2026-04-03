---
name: add-bloc
description: Creates a BLoC (event, state, bloc files) for a feature's presentation layer using Freezed, bloc_concurrency, injectable, and the wrapper/content screen split. Use when the user wants to add a BLoC, event, state, or presentation layer for a feature after the domain layer is ready.
---

# Add BLoC

## Confirm before writing

1. **Feature slug** and **topic** (e.g. feature `booking`, topic `booking_list`)
2. **Use cases** to inject (from the already-created domain layer)
3. **Events** to handle (name, payload)
4. **State fields** needed (domain entities to expose, whether any fields are form inputs)

---

## Directory layout

```
lib/src/features/<feature>/presentation/bloc/<topic>_bloc/
  <feature>_<topic>_bloc.dart     ← main file (parts + class)
  <feature>_<topic>_event.dart    ← part of bloc
  <feature>_<topic>_state.dart    ← part of bloc
  <feature>_<topic>_bloc.freezed.dart  ← generated, never edit
```

---

## File 1 — `<feature>_<topic>_bloc.dart`

```dart
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:<package>/src/core/bloc/field_state/field_state.dart';
import 'package:<package>/src/core/bloc/state_status/state_status.dart';
import 'package:<package>/src/core/error/error.dart';
import 'package:<package>/src/core/usecases/use_case.dart';
import 'package:<package>/src/features/<feature>/domain/usecases/<feature>_<action>_use_case.dart';
// import other use cases and entities as needed

part '<feature>_<topic>_event.dart';
part '<feature>_<topic>_state.dart';
part '<feature>_<topic>_bloc.freezed.dart';

@Injectable()
class <Topic>Bloc extends Bloc<<Topic>Event, <Topic>State> {
  final <Action>UseCase _<action>UseCase;

  <Topic>Bloc(this._<action>UseCase) : super(const <Topic>State()) {
    on<<Topic>Started>(_onStarted, transformer: droppable());
    on<<Topic>Refreshed>(_onRefreshed, transformer: restartable());
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

**Transformer guide:**
| Transformer | Use when |
|-------------|----------|
| `droppable()` | Ignore duplicate taps while loading (load, refresh button) |
| `sequential()` | Queue writes (save, update) |
| `restartable()` | Only the latest matters (search, system events) |

Every async `on<>` handler **must** have a transformer. Synchronous handlers need none.

---

## File 2 — `<feature>_<topic>_event.dart`

```dart
part of '<feature>_<topic>_bloc.dart';

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

## File 3 — `<feature>_<topic>_state.dart`

```dart
part of '<feature>_<topic>_bloc.dart';

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
| `flutter_bloc`, `bloc_concurrency` | Any `data/` layer import |
| `freezed_annotation`, `injectable` | `Analytics.track(...)` |
| Own feature's `domain/` (usecases, entities) | Another feature's BLoC or presentation |
| `core/bloc/` (`StateStatus`, `FieldState`, `Failure`) | `dio`, `shared_preferences`, or any platform package |

---

## After files are created

Run code generation:
```bash
dart run build_runner build -d
```

Verify `<feature>_<topic>_bloc.freezed.dart` was generated. Fix any analyzer issues.

---

## Rule compliance checklist

- [ ] Extends `Bloc<Event, State>` — never `Cubit`
- [ ] `@Injectable()` — never `@LazySingleton` or `@Singleton`
- [ ] Every async `on<>` has a `bloc_concurrency` transformer
- [ ] Events: `@freezed sealed class` with `part of` — no manual subclasses
- [ ] State uses `@Default(StateStatus.initial()) StateStatus status` — global errors use `StateStatus.error(Failure)`, not `String? errorMessage`
- [ ] Input fields use `FieldState<T>`, not `TextEditingController`
- [ ] `FailureType.inlineError` mapped to field, not `StateStatus.error`
- [ ] No `data/` imports, no `Analytics.track()`
- [ ] All files prefixed with feature name (`<feature>_<topic>_bloc.dart`)
- [ ] `build_runner` ran and generated file exists
