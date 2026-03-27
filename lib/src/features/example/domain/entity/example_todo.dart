import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final DateTime createdAt;
  final String title;
  final String description;
  final bool isDone;

  const Todo({
    required this.createdAt,
    required this.title,
    required this.description,
    required this.isDone,
  });

  @override
  List<Object?> get props => [createdAt, title, description, isDone];
}
