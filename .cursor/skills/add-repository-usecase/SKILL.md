---
name: add-repository-usecase
description: Creates a domain repository interface, one or more UseCases, and optionally a repository implementation wired to a data source. Use when the user wants to add a repository, use case, domain method, or wire a data source to the domain layer for a feature.
---

# Add Repository + UseCase

## Confirm before writing

1. **Feature slug** (e.g. `booking`) and **package name** from `pubspec.yaml` (`name:` field).
2. **Repository methods** to declare (name, return type, parameters).
3. **UseCase(s)** to create (one per method is typical).
4. **Data source available?** If yes, create the repository impl too.

---

## Step 1 — Domain repository interface

File: `lib/src/features/<feature>/domain/repository/<feature>_repository.dart`

```dart
import 'package:<package>/src/core/utils/typedef.dart';
// import entities as needed

abstract class <Feature>Repository {
  FutureEither<ReturnType> methodName(ParamType param);
  FutureEither<void> setMethodName(ParamType param);
}
```

Rules:
- ❌ No Flutter imports, no `data/` imports, no `freezed_annotation`
- Return types: always `FutureEither<T>` or `StreamEither<T>` — never write `Future<Either<...>>` in full
- `abstract class` only (no `interface` keyword needed)

---

## Step 2 — Analytics events

Add an event class to `lib/src/features/<feature>/domain/analytics/<feature>_events.dart` for **each new UseCase**:

```dart
final class <MethodName>UseCaseEvent extends AnalyticsEvent {
  const <MethodName>UseCaseEvent({required super.name, super.properties});

  factory <MethodName>UseCaseEvent.success({Map<String, dynamic>? properties}) =>
      <MethodName>UseCaseEvent(name: '<method_name>_use_case_success', properties: properties);

  factory <MethodName>UseCaseEvent.failure({required Map<String, dynamic> properties}) =>
      <MethodName>UseCaseEvent(name: '<method_name>_use_case_failure', properties: properties);
}
```

Event name format: `<method_name>_use_case_success` / `<method_name>_use_case_failure` (snake_case).

---

## Step 3 — UseCase

File: `lib/src/features/<feature>/domain/usecases/<feature>_<method>_use_case.dart`

**No parameters (`NoParams`):**
```dart
import 'package:injectable/injectable.dart';
import 'package:<package>/src/core/monitoring/analytics/analytics.dart';
import 'package:<package>/src/core/monitoring/analytics/analytics_events.dart';
import 'package:<package>/src/core/usecases/use_case.dart';
import 'package:<package>/src/core/utils/typedef.dart';
import 'package:<package>/src/features/<feature>/domain/analytics/<feature>_events.dart';
import 'package:<package>/src/features/<feature>/domain/repository/<feature>_repository.dart';

@LazySingleton()
class <MethodName>UseCase extends UseCase<ReturnType, NoParams> {
  final <Feature>Repository _repo;

  <MethodName>UseCase(this._repo);

  @override
  FutureEither<ReturnType> call(NoParams params) async {
    final result = await _repo.methodName();
    return result.fold(
      (failure) {
        Analytics.track(<MethodName>UseCaseEvent.failure(properties: {
          AnalyticsPropertyKeys.failureMessage: failure.message,
          AnalyticsPropertyKeys.failureType: failure.type.name,
          AnalyticsPropertyKeys.failureSource: failure.source,
        }));
        return result;
      },
      (_) {
        Analytics.track(<MethodName>UseCaseEvent.success());
        return result;
      },
    );
  }
}
```

**With parameters — define `Params` class in the same file, below the UseCase:**
```dart
@LazySingleton()
class <MethodName>UseCase extends UseCase<ReturnType, <MethodName>Params> {
  // ... same body, use params.<field> when calling _repo
}

class <MethodName>Params {
  const <MethodName>Params({required this.fieldName});
  final FieldType fieldName;
}
```

Naming rules:
- Class: `<MethodName>UseCase` — suffix is `UseCase` (capital C), never `Usecase`
- File: `<feature>_<method>_use_case.dart` — two words `use_case` (never `usecase`)

---

## Step 4 — Repository implementation (only when datasource exists)

File: `lib/src/features/<feature>/data/repository/<feature>_repository_impl.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:<package>/src/core/error/error.dart';
import 'package:<package>/src/core/utils/typedef.dart';
import 'package:<package>/src/features/<feature>/data/datasource/<feature>_local_data_source.dart';
import 'package:<package>/src/features/<feature>/data/datasource/<feature>_remote_data_source.dart';
import 'package:<package>/src/features/<feature>/domain/repository/<feature>_repository.dart';

@Singleton(as: <Feature>Repository)
class <Feature>RepositoryImpl implements <Feature>Repository {
  final <Feature>LocalDataSource _localDataSource;
  final <Feature>RemoteDataSource _remoteDataSource;

  <Feature>RepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  FutureEither<ReturnType> methodName(ParamType param) async {
    try {
      final result = await _localDataSource.methodName(param: param);
      return Right(result);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.methodName'));
    }
  }
}
```

Rules:
- `@Singleton(as: <Feature>Repository)` — binds impl to the interface
- Always `try/on Exception catch (e)` → `e.toFailure(source: '$runtimeType.<methodName>')`
- Return `Right(value)` on success, `Left(e.toFailure(...))` on failure
- ❌ Never construct `Failure.*` variants manually
- ❌ No analytics — analytics belong only in UseCases
- Inject only data sources through constructor; never call `GetIt.instance` inside the class

---

## Checklist

- [ ] Repository interface in `domain/repository/` — returns `FutureEither<T>`
- [ ] Analytics event class(es) added to `domain/analytics/<feature>_events.dart`
- [ ] UseCase class named `*UseCase` in file `*_use_case.dart`
- [ ] `Params` class defined below UseCase in same file (if not `NoParams`)
- [ ] Repository impl created only if datasource exists — `@Singleton(as: Interface)`
- [ ] All exceptions caught at repo level with `e.toFailure(source: '$runtimeType.method')`
- [ ] Run `dart run build_runner build -d` after adding `@LazySingleton` / `@Singleton`
