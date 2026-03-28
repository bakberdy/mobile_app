part of 'example_todos_bloc.dart';

@freezed
sealed class ExampleTodosEvent with _$ExampleTodosEvent {
  const factory ExampleTodosEvent.started() = ExampleTodosStarted;
  const factory ExampleTodosEvent.refreshed() = ExampleTodosRefreshed;
  const factory ExampleTodosEvent.titleChanged(String value) =
      ExampleTodosTitleChanged;
  const factory ExampleTodosEvent.descriptionChanged(String value) =
      ExampleTodosDescriptionChanged;
  const factory ExampleTodosEvent.doneChanged(bool value) =
      ExampleTodosDoneChanged;
  const factory ExampleTodosEvent.editRequested(Todo todo) =
      ExampleTodosEditRequested;
  const factory ExampleTodosEvent.clearRequested() = ExampleTodosClearRequested;
  const factory ExampleTodosEvent.submitted() = ExampleTodosSubmitted;
  const factory ExampleTodosEvent.deleted(String id) = ExampleTodosDeleted;
  const factory ExampleTodosEvent.toggled(Todo todo) = ExampleTodosToggled;
}
