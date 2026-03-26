---
name: add-api-endpoint
description: Adds a new API endpoint constant to a feature's ApiEndpoints class and wires a corresponding method in the remote data source using ApiClient. Use when the user wants to add an endpoint, API call, HTTP method, or remote data source method to a feature.
---

# Add API Endpoint

## Files to edit (per feature)

| File | Purpose |
|------|---------|
| `lib/src/features/<feature>/consts/api_endpoints.dart` | Endpoint URL constant |
| `lib/src/features/<feature>/data/datasource/<feature>_remote_data_source.dart` | Abstract method + implementation |

## Step 1 — Add the endpoint constant

Open `<feature>/consts/api_endpoints.dart` and add a `static const String` to `ApiEndpoints`:

```dart
class ApiEndpoints {
  static const String existingEndpoint = 'https://api.example.com/existing';
  static const String newEndpoint = 'https://api.example.com/new-path'; // ← add
}
```

## Step 2 — Add the abstract method

Add the method signature to the abstract data source class:

```dart
abstract class UserConfigRemoteDataSource {
  // existing methods ...
  Future<ReturnType> methodName({required ParamType param});
}
```

## Step 3 — Implement the method

Implement in the `*Impl` class using `ApiClient`. The impl must have `ApiClient` injected via constructor:

```dart
@Singleton(as: UserConfigRemoteDataSource)
class UserConfigRemoteDataSourceImpl implements UserConfigRemoteDataSource {
  final ApiClient _apiClient;

  UserConfigRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ReturnType> methodName({required ParamType param}) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.newEndpoint,
      queryParameters: {'key': param},
    );
    return ReturnTypeModel.fromJson(response.data!);
  }
}
```

## ApiClient method signatures

Use the appropriate HTTP verb:

| Verb | Use case |
|------|----------|
| `_apiClient.get(path, {queryParameters, cancelToken})` | Fetch data |
| `_apiClient.post(path, {data, cancelToken})` | Create |
| `_apiClient.put(path, {data, cancelToken})` | Replace |
| `_apiClient.patch(path, {data, cancelToken})` | Partial update |
| `_apiClient.delete(path, {queryParameters, cancelToken})` | Remove |

All methods return `Future<ApiResponse<T>>`. Access the body via `response.data`.

## Rules

- ❌ Never import `Dio` directly — always use `ApiClient` from `core/api/client/api_client.dart`
- ❌ Never catch exceptions in the data source — let them propagate; the repository catches with `e.toFailure(source:)`
- ✅ Add `ApiCancelToken? cancelToken` parameter for slow/user-interruptible requests (search, uploads, paginated fetches) — see `cancel-token.mdc`
- ✅ Inject `ApiClient` via constructor, never create it ad hoc

## Checklist

- [ ] Endpoint constant added to `ApiEndpoints`
- [ ] Abstract method declared in data source interface
- [ ] Implementation added in `*Impl` using `_apiClient`
- [ ] `ApiClient` injected via constructor (if not already present)
- [ ] No `Dio` imports in the data source file
- [ ] No try/catch in the data source (exceptions handled at repository level)
