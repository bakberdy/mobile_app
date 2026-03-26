---
name: add-entity-model
description: Creates a domain entity (Equatable, no Freezed) and optionally a data model (extends entity, json_serializable, no Freezed) for a feature. Use when the user wants to add an entity, domain class, data model, JSON model, or API response model.
---

# Add Entity + Model

## Confirm before writing

1. **Feature slug** and **class name** (e.g. feature `booking`, name `Booking`)
2. **Fields** with their types
3. **Snake_case JSON keys** that differ from Dart field names (for `@JsonKey`)
4. **Model needed?** Only create it if the entity is serialized to/from JSON (API response/request)

---

## File locations

```
lib/src/features/<feature>/
  domain/
    entity/
      <feature>_<name>.dart          ← entity
  data/
    models/
      <feature>_<name>_model.dart    ← model (only if JSON needed)
```

---

## Entity — `domain/entity/<feature>_<name>.dart`

For a **data class** (most common):

```dart
import 'package:equatable/equatable.dart';

class <Name> extends Equatable {
  final String id;
  final String title;
  final int count;

  const <Name>({
    required this.id,
    required this.title,
    required this.count,
  });

  @override
  List<Object?> get props => [id, title, count];
}
```

For a **simple enum** (no Equatable needed — enums have built-in equality):

```dart
enum <Name> {
  valueOne,
  valueTwo;

  static <Name>? fromString(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    for (final v in <Name>.values) {
      if (v.name == value.trim()) return v;
    }
    return null;
  }
}
```

### Entity rules
| ✅ Do | ❌ Never |
|-------|---------|
| Extends `Equatable`, declares `props` | Add `Entity` suffix to class or file name |
| Pure Dart — no Flutter, no JSON | Use `@freezed` / `freezed_annotation` |
| Prefix file with feature name | Add `fromJson` / `toJson` |
| Keep in `domain/entity/` | Import from `data/` layer |

---

## Model — `data/models/<feature>_<name>_model.dart`

Create only when the entity is received from or sent to an API.

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:<package>/src/features/<feature>/domain/entity/<feature>_<name>.dart';

part '<feature>_<name>_model.g.dart';

@JsonSerializable()
class <Name>Model extends <Name> {
  const <Name>Model({
    required super.id,
    required super.title,
    required super.count,
  });

  factory <Name>Model.fromJson(Map<String, dynamic> json) =>
      _$<Name>ModelFromJson(json);

  Map<String, dynamic> toJson() => _$<Name>ModelToJson(this);

  /// Used when serializing a domain object for a POST/PUT request.
  factory <Name>Model.fromEntity(<Name> entity) => <Name>Model(
        id: entity.id,
        title: entity.title,
        count: entity.count,
      );
}
```

### Model rules
| ✅ Do | ❌ Never |
|-------|---------|
| Extends the **entity** class (not a separate class) | Add `@freezed` |
| `fromJson` + `toJson` via `json_serializable` | Add `toEntity()` — model IS the entity |
| `fromEntity()` named constructor for write-back | Import model in BLoC, UseCase, or presentation |
| `@JsonKey(name:)` for snake_case ↔ camelCase | Prefix file with feature name — wait, DO prefix |
| Prefix file: `<feature>_<name>_model.dart` | Declare model in `domain/` |

### Repository usage
```dart
// Reading (GET) — RouteModel satisfies Route, no conversion needed
final model = RouteModel.fromJson(response.data!);
return Right(model); // typed as FutureEither<Route>

// Writing (POST/PUT) — convert domain object back to model
final body = RouteModel.fromEntity(route).toJson();
await _apiClient.post(ApiEndpoints.routes, data: body);
```

---

## After creating the model

Run code generation to produce the `.g.dart` file:

```bash
dart run build_runner build -d
```

Verify `<feature>_<name>_model.g.dart` is generated in `data/models/`.

---

## Checklist

- [ ] Entity in `domain/entity/`, file prefixed with feature name
- [ ] Entity extends `Equatable` with `props` list (or is an enum)
- [ ] No `Entity` suffix on class or file name
- [ ] No `@freezed`, no `fromJson`, no `toJson` on entity
- [ ] Model in `data/models/`, file prefixed with feature name, suffix `_model.dart`
- [ ] Model **extends** the entity class — not a standalone class
- [ ] Model has `fromJson`, `toJson`, and `fromEntity()` constructor
- [ ] No `@freezed` on model
- [ ] No `toEntity()` method — unnecessary since model IS the entity
- [ ] Model not imported by BLoC, UseCase, or presentation — repository only
- [ ] `build_runner` ran and `.g.dart` file generated
