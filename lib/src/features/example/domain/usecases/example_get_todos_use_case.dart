import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/example/domain/analytics/example_events.dart';
import 'package:mobile_app/src/features/example/domain/entity/example_todo.dart';
import 'package:mobile_app/src/features/example/domain/repository/example_repository.dart';

@LazySingleton()
class GetTodosUseCase extends UseCase<List<Todo>, NoParams> {
  final ExampleRepository _repo;

  GetTodosUseCase(this._repo);

  @override
  FutureEither<List<Todo>> call(NoParams params) async {
    final result = await _repo.getTodos();
    return result.fold(
      (failure) {
        Analytics.track(
          GetTodosUseCaseEvent.failure(
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
        Analytics.track(GetTodosUseCaseEvent.success());
        return result;
      },
    );
  }
}
