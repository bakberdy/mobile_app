part of 'example_todo_editor_bloc.dart';

@freezed
sealed class ExampleTodoEditorEvent with _$ExampleTodoEditorEvent {
  const factory ExampleTodoEditorEvent.started(Todo? todo) =
      ExampleTodoEditorStarted;
  const factory ExampleTodoEditorEvent.titleChanged(String value) =
      ExampleTodoEditorTitleChanged;
  const factory ExampleTodoEditorEvent.descriptionChanged(String value) =
      ExampleTodoEditorDescriptionChanged;
  const factory ExampleTodoEditorEvent.doneChanged(bool value) =
      ExampleTodoEditorDoneChanged;
  const factory ExampleTodoEditorEvent.submitted() = ExampleTodoEditorSubmitted;
}
