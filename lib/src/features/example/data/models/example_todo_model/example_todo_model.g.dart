// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
  createdAt: DateTime.parse(json['created_at'] as String),
  title: json['title'] as String,
  description: json['description'] as String,
  isDone: json['is_done'] as bool,
);

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
  'created_at': instance.createdAt.toIso8601String(),
  'title': instance.title,
  'description': instance.description,
  'is_done': instance.isDone,
};
