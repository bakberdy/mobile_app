import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/bloc/field_state/field_state.dart';
import 'package:mobile_app/src/core/bloc/state_status/state_status.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';
import 'package:mobile_app/src/features/example/domain/usecases/example_create_todo_use_case.dart';
import 'package:mobile_app/src/features/example/domain/usecases/example_get_todos_use_case.dart';
import 'package:mobile_app/src/features/example/domain/usecases/example_remove_todo_use_case.dart';
import 'package:mobile_app/src/features/example/domain/usecases/example_update_todo_use_case.dart';

part 'example_todos_bloc.freezed.dart';
part 'example_todos_event.dart';
part 'example_todos_state.dart';

@Injectable()
class ExampleTodosBloc extends Bloc<ExampleTodosEvent, ExampleTodosState> {
  ExampleTodosBloc(
    this._getTodosUseCase,
    this._createTodoUseCase,
    this._updateTodoUseCase,
    this._removeTodoUseCase,
  ) : super(ExampleTodosState()) {
    on<ExampleTodosStarted>(_onStarted, transformer: droppable());
    on<ExampleTodosRefreshed>(_onRefreshed, transformer: restartable());
    on<ExampleTodosSubmitted>(_onSubmitted, transformer: sequential());
    on<ExampleTodosDeleted>(_onDeleted, transformer: sequential());
    on<ExampleTodosToggled>(_onToggled, transformer: sequential());
    on<ExampleTodosTitleChanged>(_onTitleChanged);
    on<ExampleTodosDescriptionChanged>(_onDescriptionChanged);
    on<ExampleTodosDoneChanged>(_onDoneChanged);
    on<ExampleTodosEditRequested>(_onEditRequested);
    on<ExampleTodosClearRequested>(_onClearRequested);
  }

  final GetTodosUseCase _getTodosUseCase;
  final CreateTodoUseCase _createTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final RemoveTodoUseCase _removeTodoUseCase;

  Future<void> _onStarted(
    ExampleTodosStarted event,
    Emitter<ExampleTodosState> emit,
  ) async {
    await _loadTodos(emit);
  }

  Future<void> _onRefreshed(
    ExampleTodosRefreshed event,
    Emitter<ExampleTodosState> emit,
  ) async {
    await _loadTodos(emit);
  }

  Future<void> _onSubmitted(
    ExampleTodosSubmitted event,
    Emitter<ExampleTodosState> emit,
  ) async {
    final title = state.titleField.value.trim();
    final description = state.descriptionField.value.trim();
    if (title.isEmpty || description.isEmpty) {
      return;
    }

    emit(state.copyWith(status: StateStatus.loading()));

    final currentTodo = state.todos.where(
      (todo) => todo.id == state.editingTodoId,
    );
    final existingTodo = currentTodo.isEmpty ? null : currentTodo.first;
    final todo = Todo(
      id:
          state.editingTodoId ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      createdAt: existingTodo?.createdAt ?? DateTime.now(),
      title: title,
      description: description,
      isDone: state.isDoneField.value,
    );

    final result = existingTodo == null
        ? await _createTodoUseCase(CreateTodoParams(todo: todo))
        : await _updateTodoUseCase(UpdateTodoParams(todo: todo));

    result.fold(
      (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
      (_) => emit(
        state.copyWith(
          status: StateStatus.success(),
          titleField: const FieldState(value: ''),
          descriptionField: const FieldState(value: ''),
          isDoneField: const FieldState(value: false),
          editingTodoId: null,
          formVersion: state.formVersion + 1,
        ),
      ),
    );

    if (result.isRight()) {
      await _loadTodos(emit, useLoadingState: false);
    }
  }

  Future<void> _onDeleted(
    ExampleTodosDeleted event,
    Emitter<ExampleTodosState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.loading()));

    final result = await _removeTodoUseCase(RemoveTodoParams(id: event.id));
    result.fold(
      (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
      (_) {
        final isEditingDeletedTodo = state.editingTodoId == event.id;
        emit(
          state.copyWith(
            status: StateStatus.success(),
            editingTodoId: isEditingDeletedTodo ? null : state.editingTodoId,
            titleField: isEditingDeletedTodo
                ? const FieldState(value: '')
                : state.titleField,
            descriptionField: isEditingDeletedTodo
                ? const FieldState(value: '')
                : state.descriptionField,
            isDoneField: isEditingDeletedTodo
                ? const FieldState(value: false)
                : state.isDoneField,
            formVersion: isEditingDeletedTodo
                ? state.formVersion + 1
                : state.formVersion,
          ),
        );
      },
    );

    if (result.isRight()) {
      await _loadTodos(emit, useLoadingState: false);
    }
  }

  Future<void> _onToggled(
    ExampleTodosToggled event,
    Emitter<ExampleTodosState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.loading()));

    final result = await _updateTodoUseCase(
      UpdateTodoParams(todo: event.todo.copyWith(isDone: !event.todo.isDone)),
    );

    result.fold(
      (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
      (_) => emit(state.copyWith(status: StateStatus.success())),
    );

    if (result.isRight()) {
      await _loadTodos(emit, useLoadingState: false);
    }
  }

  void _onTitleChanged(
    ExampleTodosTitleChanged event,
    Emitter<ExampleTodosState> emit,
  ) {
    emit(
      state.copyWith(
        titleField: FieldState(
          value: event.value,
          status: event.value.trim().isEmpty
              ? FieldStatus.pure
              : FieldStatus.valid,
        ),
      ),
    );
  }

  void _onDescriptionChanged(
    ExampleTodosDescriptionChanged event,
    Emitter<ExampleTodosState> emit,
  ) {
    emit(
      state.copyWith(
        descriptionField: FieldState(
          value: event.value,
          status: event.value.trim().isEmpty
              ? FieldStatus.pure
              : FieldStatus.valid,
        ),
      ),
    );
  }

  void _onDoneChanged(
    ExampleTodosDoneChanged event,
    Emitter<ExampleTodosState> emit,
  ) {
    emit(
      state.copyWith(
        isDoneField: FieldState(value: event.value, status: FieldStatus.valid),
      ),
    );
  }

  void _onEditRequested(
    ExampleTodosEditRequested event,
    Emitter<ExampleTodosState> emit,
  ) {
    emit(
      state.copyWith(
        editingTodoId: event.todo.id,
        titleField: FieldState(
          value: event.todo.title,
          status: FieldStatus.valid,
        ),
        descriptionField: FieldState(
          value: event.todo.description,
          status: FieldStatus.valid,
        ),
        isDoneField: FieldState(
          value: event.todo.isDone,
          status: FieldStatus.valid,
        ),
        formVersion: state.formVersion + 1,
      ),
    );
  }

  void _onClearRequested(
    ExampleTodosClearRequested event,
    Emitter<ExampleTodosState> emit,
  ) {
    emit(
      state.copyWith(
        editingTodoId: null,
        titleField: const FieldState(value: ''),
        descriptionField: const FieldState(value: ''),
        isDoneField: const FieldState(value: false),
        formVersion: state.formVersion + 1,
      ),
    );
  }

  Future<void> _loadTodos(
    Emitter<ExampleTodosState> emit, {
    bool useLoadingState = true,
  }) async {
    if (useLoadingState) {
      emit(state.copyWith(status: StateStatus.loading()));
    }

    final result = await _getTodosUseCase(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: StateStatus.error(failure))),
      (todos) =>
          emit(state.copyWith(status: StateStatus.success(), todos: todos)),
    );
  }
}
