import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/error/error.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/example/data/datasource/example_local_data_source.dart';
import 'package:mobile_app/src/features/example/data/models/example_todo_model/example_todo_model.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';
import 'package:mobile_app/src/features/example/domain/repository/example_repository.dart';

@LazySingleton(as: ExampleRepository)
class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleLocalDataSource _localDataSource;

  ExampleRepositoryImpl(this._localDataSource);

  @override
  FutureEither<void> createTodo(Todo todo) async {
    try {
      await _localDataSource.createTodo(TodoModel.fromEntity(todo));
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.createTodo'));
    }
  }

  @override
  FutureEither<List<Todo>> getTodos() async {
    try {
      final todos = await _localDataSource.getTodos();
      return Right(todos);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.getTodos'));
    }
  }

  @override
  FutureEither<void> removeTodo(String id) async {
    try {
      await _localDataSource.removeTodo(id);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.removeTodo'));
    }
  }

  @override
  FutureEither<void> updateTodo(Todo todo) async {
    try {
      await _localDataSource.updateTodo(TodoModel.fromEntity(todo));
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.updateTodo'));
    }
  }
}
