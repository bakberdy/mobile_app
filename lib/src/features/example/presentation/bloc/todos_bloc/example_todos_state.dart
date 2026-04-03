part of 'example_todos_bloc.dart';

@freezed
sealed class ExampleTodosState with _$ExampleTodosState {
  const factory ExampleTodosState({
    @Default(<Todo>[]) List<Todo> todos,
    @Default(StateStatus.initial()) StateStatus status,
    @Default(FieldState(value: '')) FieldState<String> titleField,
    @Default(FieldState(value: '')) FieldState<String> descriptionField,
    @Default(FieldState(value: false)) FieldState<bool> isDoneField,
    String? editingTodoId,
    @Default(0) int formVersion,
  }) = _ExampleTodosState;
}
