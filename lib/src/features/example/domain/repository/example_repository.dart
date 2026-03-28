import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';

abstract class ExampleRepository {
  FutureEither<List<Todo>> getTodos();
  FutureEither<void> createTodo(Todo todo);
  FutureEither<void> updateTodo(Todo todo);
  FutureEither<void> removeTodo(String id);
}
