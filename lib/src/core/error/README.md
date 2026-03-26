# Error handling: Failures and Exceptions

## Concepts

- **Failure** — business/UI layer. Represents something that went wrong in a way the app can handle (e.g. show a message, highlight a field).
- **Exception** — data/source layer. Thrown by APIs, parsers, or platform code. Must be caught and converted into failures.

Exceptions must be handled in **repositories** and mapped there to **failures**. Do not let exceptions bubble up to blocs or UI.

---

## Repository: mapping exceptions to failures

1. Catch exceptions in the repository.
2. Map them to `Failure` using a consistent **source** string: `feature_name/repository_name.method` (e.g. `auth/login_repository.signIn`).
3. Return `Left(failure)` from the repository so the use case/bloc receives a `Failure`.

**Example — general API error:**

Use `ExceptionX.toFailure(source: 'feature/repository.method')` to map known exception types to failures.

**Example — inline/field errors (e.g. validation from API):**

When the API returns field-level errors, map to a failure with `FailureType.inlineError` so the bloc can map them to `FieldState` instead of a global error:

```dart
if (e is ApiException &&
    e.response?.data is DataMap &&
    e.response?.data['fieldErrors'] != null) {
  return Left(Failure.api(
    type: FailureType.inlineError,
    source: 'feature_name/repository_name.method',
    data: e.response?.data,
  ));
}
```

Then in the bloc, handle this failure by updating the relevant `FieldState<T>` (e.g. `emailField`, `passwordField`) with the field errors from `failure.data`, not by emitting to a global `failure` field.

---

## Bloc: storing and handling failures

- In bloc state, keep the full **`Failure`** when you need to show a message or send analytics (e.g. `Failure? failure` and `StateStatus`).
- **Analytics:** when you receive a `Failure` in the bloc, report it to your analytics.
- **Global vs inline:**
  - For **global** errors (snackbar, toast, banner, etc.): emit `state.copyWith(status: StateStatus.error, failure: failure)`.
  - For **inline** errors (forms): do **not** put the failure in the global `failure` field. Instead, map the failure (e.g. from `failure.data`) into the corresponding `FieldState<T>.error` and emit updated field states.

---

## UI: showing failures

### Global errors (BlocListener)

When the bloc state has a global error, show it based on `Failure.type`:

```dart
if (state.someStatus == StateStatus.error && state.failure != null) {
  final failure = state.failure!;
  final message = failure.message ?? failure.defaultMessage(context);
  switch (failure.type) {
    case FailureType.snackbar:
      context.showSnackBar(message, type: SnackBarType.error);
      break;
    case FailureType.banner:
      // show banner
      break;
    case FailureType.alert:
      // show dialog
      break;
    case FailureType.fullScreenError:
      // show full-screen error
      break;
    case FailureType.silent:
      // no UI, e.g. analytics only
      break;
    case FailureType.inlineError:
      // handle in BlocBuilder via FieldState (see below)
      break;
  }
}
```

(Adjust `state.someStatus` and `state.failure` to your actual state field names.)

### Inline / field errors (BlocBuilder)

For `FailureType.inlineError`, do **not** show a global message. Handle the error in the form using `FieldState.error`:

```dart
TextFormField(
  decoration: InputDecoration(
    errorText: emailField.error,
  ),
)
```

Where `emailField` is a `FieldState<String?>` whose `error` is set from the failure’s field errors in the bloc.

---

## Summary

| Layer      | Responsibility |
|-----------|----------------|
| Repository | Catch exceptions, map to `Failure` with `source: 'feature/repository.method'`. Use `FailureType.inlineError` + `data` for API field errors. |
| Bloc       | Store `Failure` for global errors; send to analytics; for inline errors, update `FieldState` only. |
| UI         | In listener: show message by `failure.type` using `failure.message ?? failure.defaultMessage(context)`. In builder: show `fieldState.error` for inline errors. |
