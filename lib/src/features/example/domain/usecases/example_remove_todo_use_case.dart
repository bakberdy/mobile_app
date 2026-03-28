import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/example/domain/analytics/example_events.dart';
import 'package:mobile_app/src/features/example/domain/repository/example_repository.dart';

@LazySingleton()
class RemoveTodoUseCase extends UseCase<void, RemoveTodoParams> {
  final ExampleRepository _repo;

  RemoveTodoUseCase(this._repo);

  @override
  FutureEither<void> call(RemoveTodoParams params) async {
    final result = await _repo.removeTodo(params.id);
    return result.fold(
      (failure) {
        Analytics.track(
          RemoveTodoUseCaseEvent.failure(
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
        Analytics.track(RemoveTodoUseCaseEvent.success());
        return result;
      },
    );
  }
}

class RemoveTodoParams {
  const RemoveTodoParams({required this.id});

  final String id;
}
