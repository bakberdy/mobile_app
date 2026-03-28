import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/storage/local_storage/local_storage.dart';
import 'package:mobile_app/src/features/example/consts/example_local_storage_consts.dart';
import 'package:mobile_app/src/features/example/data/models/example_todo_model/example_todo_model.dart';

abstract class ExampleLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> createTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> removeTodo(String id);
}

@LazySingleton(as: ExampleLocalDataSource)
class ExampleLocalDataSourceImpl implements ExampleLocalDataSource {
  final LocalStorage _localStorage;

  ExampleLocalDataSourceImpl(this._localStorage);

  @override
  Future<void> createTodo(TodoModel todo) async {
    final todos = await _readTodos();
    todos.add(todo);
    await _writeTodos(todos);
  }

  @override
  Future<List<TodoModel>> getTodos() => _readTodos();

  @override
  Future<void> removeTodo(String id) async {
    final todos = await _readTodos();
    final nextTodos = todos.where((todo) => todo.id != id).toList();

    if (nextTodos.length == todos.length) {
      throw Exception('Todo with id $id was not found.');
    }

    await _writeTodos(nextTodos);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final todos = await _readTodos();
    final todoIndex = todos.indexWhere((item) => item.id == todo.id);

    if (todoIndex == -1) {
      throw Exception('Todo with id ${todo.id} was not found.');
    }

    todos[todoIndex] = todo;
    await _writeTodos(todos);
  }

  Future<List<TodoModel>> _readTodos() async {
    final rawTodos = await _localStorage.read(
      key: ExampleLocalStorageConsts.todosKey,
    );
    if (rawTodos == null || rawTodos.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(rawTodos) as List<dynamic>;
    return decoded
        .map(
          (item) => TodoModel.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }

  Future<void> _writeTodos(List<TodoModel> todos) async {
    final encodedTodos = jsonEncode(
      todos.map((todo) => todo.toJson()).toList(),
    );

    await _localStorage.write(
      key: ExampleLocalStorageConsts.todosKey,
      value: encodedTodos,
    );
  }
}
