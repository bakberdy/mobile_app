import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';

part 'example_todo_model.g.dart';

@JsonSerializable()
class TodoModel extends Todo {
  const TodoModel({
    @JsonKey(name: 'created_at') required super.createdAt,
    required super.title,
    required super.description,
    @JsonKey(name: 'is_done') required super.isDone,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  factory TodoModel.fromEntity(Todo entity) => TodoModel(
        createdAt: entity.createdAt,
        title: entity.title,
        description: entity.description,
        isDone: entity.isDone,
      );
}
