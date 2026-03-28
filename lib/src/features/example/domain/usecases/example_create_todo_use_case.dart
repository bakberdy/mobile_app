import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/example/domain/analytics/example_events.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';
import 'package:mobile_app/src/features/example/domain/repository/example_repository.dart';

@LazySingleton()
class CreateTodoUseCase extends UseCase<void, CreateTodoParams> {
  final ExampleRepository _repo;

  CreateTodoUseCase(this._repo);

  @override
  FutureEither<void> call(CreateTodoParams params) async {
    final result = await _repo.createTodo(params.todo);
    return result.fold(
      (failure) {
        Analytics.track(
          CreateTodoUseCaseEvent.failure(
            properties: {
              AnalyticsPropertyKeys.failureMessage: failure.message,
              AnalyticsPropertyKeys.failureType: failure.type.name,
              AnalyticsPropertyKeys.failureSource: failure.source,
            },
          ),
        );
        return result;
      },
      (_) {
        Analytics.track(CreateTodoUseCaseEvent.success());
        return result;
      },
    );
  }
}

class CreateTodoParams {
  const CreateTodoParams({required this.todo});

  final Todo todo;
}
