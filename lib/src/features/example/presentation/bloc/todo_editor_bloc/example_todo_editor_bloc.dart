import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/bloc/state_status.dart';
import 'package:mobile_app/src/core/bloc/states/field_state.dart';
import 'package:mobile_app/src/core/error/error.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';
import 'package:mobile_app/src/features/example/domain/usecases/example_create_todo_use_case.dart';
import 'package:mobile_app/src/features/example/domain/usecases/example_update_todo_use_case.dart';

part 'example_todo_editor_event.dart';
part 'example_todo_editor_state.dart';
part 'example_todo_editor_bloc.freezed.dart';

@Injectable()
class ExampleTodoEditorBloc
    extends Bloc<ExampleTodoEditorEvent, ExampleTodoEditorState> {
  ExampleTodoEditorBloc(this._createTodoUseCase, this._updateTodoUseCase)
    : super(const ExampleTodoEditorState()) {
    on<ExampleTodoEditorStarted>(_onStarted);
    on<ExampleTodoEditorTitleChanged>(_onTitleChanged);
    on<ExampleTodoEditorDescriptionChanged>(_onDescriptionChanged);
    on<ExampleTodoEditorDoneChanged>(_onDoneChanged);
    on<ExampleTodoEditorSubmitted>(_onSubmitted, transformer: sequential());
  }

  final CreateTodoUseCase _createTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;

  void _onStarted(
    ExampleTodoEditorStarted event,
    Emitter<ExampleTodoEditorState> emit,
  ) {
    final todo = event.todo;
    emit(
      state.copyWith(
        todo: todo,
        createdAt: todo?.createdAt ?? DateTime.now(),
        titleField: FieldState(
          value: todo?.title ?? '',
          status: todo == null ? FieldStatus.pure : FieldStatus.valid,
        ),
        descriptionField: FieldState(
          value: todo?.description ?? '',
          status: todo == null ? FieldStatus.pure : FieldStatus.valid,
        ),
        isDoneField: FieldState(
          value: todo?.isDone ?? false,
          status: FieldStatus.valid,
        ),
        formVersion: state.formVersion + 1,
        failure: null,
        status: StateStatus.initial,
      ),
    );
  }

  void _onTitleChanged(
    ExampleTodoEditorTitleChanged event,
    Emitter<ExampleTodoEditorState> emit,
  ) {
    final trimmedValue = event.value.trim();
    emit(
      state.copyWith(
        titleField: state.titleField.copyWith(
          value: event.value,
          isDirty: true,
          status: trimmedValue.isEmpty ? FieldStatus.pure : FieldStatus.valid,
          error: null,
        ),
        failure: null,
      ),
    );
  }

  void _onDescriptionChanged(
    ExampleTodoEditorDescriptionChanged event,
    Emitter<ExampleTodoEditorState> emit,
  ) {
    final trimmedValue = event.value.trim();
    emit(
      state.copyWith(
        descriptionField: state.descriptionField.copyWith(
          value: event.value,
          isDirty: true,
          status: trimmedValue.isEmpty ? FieldStatus.pure : FieldStatus.valid,
          error: null,
        ),
        failure: null,
      ),
    );
  }

  void _onDoneChanged(
    ExampleTodoEditorDoneChanged event,
    Emitter<ExampleTodoEditorState> emit,
  ) {
    emit(
      state.copyWith(
        isDoneField: state.isDoneField.copyWith(
          value: event.value,
          isDirty: true,
          status: FieldStatus.valid,
        ),
        failure: null,
      ),
    );
  }

  Future<void> _onSubmitted(
    ExampleTodoEditorSubmitted event,
    Emitter<ExampleTodoEditorState> emit,
  ) async {
    if (state.status == StateStatus.loading || state.status == StateStatus.success) {
      return;
    }

    final title = state.titleField.value.trim();
    final description = state.descriptionField.value.trim();
    final titleError = title.isEmpty ? 'required' : null;
    final descriptionError = description.isEmpty ? 'required' : null;

    if (titleError != null || descriptionError != null) {
      emit(
        state.copyWith(
          titleField: state.titleField.copyWith(
            status: titleError == null ? FieldStatus.valid : FieldStatus.invalid,
            error: titleError,
            isDirty: true,
          ),
          descriptionField: state.descriptionField.copyWith(
            status: descriptionError == null
                ? FieldStatus.valid
                : FieldStatus.invalid,
            error: descriptionError,
            isDirty: true,
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(status: StateStatus.loading, failure: null));

    final currentTodo = state.todo;
    final createdAt = state.createdAt ?? currentTodo?.createdAt ?? DateTime.now();
    final todo = Todo(
      id: currentTodo?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      createdAt: createdAt,
      title: title,
      description: description,
      isDone: state.isDoneField.value,
    );

    final result = currentTodo == null
        ? await _createTodoUseCase(CreateTodoParams(todo: todo))
        : await _updateTodoUseCase(UpdateTodoParams(todo: todo));

    result.fold(
      (failure) => emit(
        state.copyWith(status: StateStatus.error, failure: failure),
      ),
      (_) => emit(state.copyWith(status: StateStatus.success, failure: null)),
    );
  }
}
