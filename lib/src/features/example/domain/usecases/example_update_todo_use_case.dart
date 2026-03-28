import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/example/domain/analytics/example_events.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';
import 'package:mobile_app/src/features/example/domain/repository/example_repository.dart';

@LazySingleton()
class UpdateTodoUseCase extends UseCase<void, UpdateTodoParams> {
  final ExampleRepository _repo;

  UpdateTodoUseCase(this._repo);

  @override
  FutureEither<void> call(UpdateTodoParams params) async {
    final result = await _repo.updateTodo(params.todo);
    return result.fold(
      (failure) {
        Analytics.track(
          UpdateTodoUseCaseEvent.failure(
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
        Analytics.track(UpdateTodoUseCaseEvent.success());
        return result;
      },
    );
  }
}

class UpdateTodoParams {
  const UpdateTodoParams({required this.todo});

  final Todo todo;
}
