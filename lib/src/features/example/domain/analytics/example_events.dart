import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';

final class GetTodosUseCaseEvent extends AnalyticsEvent {
  const GetTodosUseCaseEvent({required super.name, super.properties});

  factory GetTodosUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      GetTodosUseCaseEvent(
        name: 'get_todos_use_case_success',
        properties: properties,
      );

  factory GetTodosUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetTodosUseCaseEvent(
    name: 'get_todos_use_case_failure',
    properties: properties,
  );
}

final class CreateTodoUseCaseEvent extends AnalyticsEvent {
  const CreateTodoUseCaseEvent({required super.name, super.properties});

  factory CreateTodoUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      CreateTodoUseCaseEvent(
        name: 'create_todo_use_case_success',
        properties: properties,
      );

  factory CreateTodoUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => CreateTodoUseCaseEvent(
    name: 'create_todo_use_case_failure',
    properties: properties,
  );
}

final class UpdateTodoUseCaseEvent extends AnalyticsEvent {
  const UpdateTodoUseCaseEvent({required super.name, super.properties});

  factory UpdateTodoUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      UpdateTodoUseCaseEvent(
        name: 'update_todo_use_case_success',
        properties: properties,
      );

  factory UpdateTodoUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => UpdateTodoUseCaseEvent(
    name: 'update_todo_use_case_failure',
    properties: properties,
  );
}

final class RemoveTodoUseCaseEvent extends AnalyticsEvent {
  const RemoveTodoUseCaseEvent({required super.name, super.properties});

  factory RemoveTodoUseCaseEvent.success({Map<String, dynamic>? properties}) =>
      RemoveTodoUseCaseEvent(
        name: 'remove_todo_use_case_success',
        properties: properties,
      );

  factory RemoveTodoUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => RemoveTodoUseCaseEvent(
    name: 'remove_todo_use_case_failure',
    properties: properties,
  );
}
