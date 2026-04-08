---
name: add-entity-model
description: Creates a domain entity (default Equatable; optional Freezed only when needed under entity/<name>/) and optionally a data model (extends entity, json_serializable, no Freezed). Use when the user wants to add an entity, domain class, data model, JSON model, or API response model.
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
      <feature>_<name>.dart           ← Equatable entity (default)
      <distinct_name>.dart           ← distinctive name (e.g. app_theme_mode.dart)
      <entity_snake_name>/           ← only if using Freezed (see below)
        <entity_snake_name>.dart
        <entity_snake_name>.freezed.dart
  data/
    models/
      <feature>_<name>_model/        ← model folder (only if JSON needed)
```

---

## Entity — Equatable (default)

Path: `domain/entity/<feature>_<name>.dart` or `domain/entity/<distinct_name>.dart`

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

---

## Entity — Freezed (only when needed)

Use only for sealed unions, many variants, or when generated `copyWith` / equality is clearly worth the cost. **Never** place `@freezed` in a single file directly under `entity/`.

Path: `domain/entity/<entity_snake_name>/<entity_snake_name>.dart` plus generated `part`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '<entity_snake_name>.freezed.dart';

@freezed
class <Name> with _$<Name> {
  const factory <Name>({
    required String id,
    required String title,
    @Default(false) bool done,
  }) = _<Name>;
}
```

Run `dart run build_runner build -d` so `<entity_snake_name>.freezed.dart` is generated next to the main file.

**`build.yaml` (project root)** sets Freezed `from_json`, `to_json`, `when`, and `map` to **`false`**. Do not add **`@JsonSerializable`**, **`json_annotation`**, or Freezed **`.fromJson`/`.toJson`** on entities. Do not call **`.map`** or **`.when`** on Freezed types — use **`switch`** / pattern matching. Put **`fromJson`/`toJson`** only on **`data/models`** classes.

### Entity rules
| ✅ Do | ❌ Never |
|-------|---------|
| Default: `Equatable` + `props`, or enum | Add `Entity` suffix to class or file name |
| Freezed only with subfolder `entity/<entity_snake_name>/` | `@freezed` on a file directly in `entity/` (no subfolder) |
| Pure Dart — no Flutter; JSON only in models | `json_annotation`, `@JsonSerializable`, entity `fromJson` / `toJson`, or `.map`/`.when` on Freezed |
| File layout per `model-entity-separation.mdc` | Import from `data/` layer |

---

## Model — `data/models/<feature>_<name>_model.dart`

Create only when the entity is received from or sent to an API.

Import the entity from its real path — flat `entity/<feature>_<name>.dart` or `entity/<entity_snake_name>/<entity_snake_name>.dart` when Freezed.

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

- [ ] Entity under `domain/entity/` — Equatable or enum in a single file, or Freezed only in `entity/<snake_name>/` with `part`
- [ ] Equatable entities: `props` defined; enums: N/A; Freezed: generated `*.freezed.dart` present after build_runner
- [ ] No `Entity` suffix on class or file name
- [ ] No `fromJson` / `toJson` on entity; `@freezed` only if justified and only under `entity/<snake_name>/` with `part`
- [ ] Model in `data/models/`, file prefixed with feature name, suffix `_model.dart`
- [ ] Model **extends** the entity class — not a standalone class
- [ ] Model has `fromJson`, `toJson`, and `fromEntity()` constructor
- [ ] No `@freezed` on model
- [ ] No `toEntity()` method — unnecessary since model IS the entity
- [ ] Model not imported by BLoC, UseCase, or presentation — repository only
- [ ] `build_runner` ran and `.g.dart` file generated
