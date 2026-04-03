part of 'example_todo_editor_bloc.dart';

@freezed
sealed class ExampleTodoEditorState with _$ExampleTodoEditorState {
  const factory ExampleTodoEditorState({
    Todo? todo,
    DateTime? createdAt,
    @Default(StateStatus.initial()) StateStatus status,
    @Default(FieldState(value: '')) FieldState<String> titleField,
    @Default(FieldState(value: '')) FieldState<String> descriptionField,
    @Default(FieldState(value: false)) FieldState<bool> isDoneField,
    @Default(0) int formVersion,
  }) = _ExampleTodoEditorState;
}
