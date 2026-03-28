import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final DateTime createdAt;
  final String title;
  final String description;
  final bool isDone;

  const Todo({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.isDone,
  });

  Todo copyWith({
    String? id,
    DateTime? createdAt,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id, createdAt, title, description, isDone];
}
