import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/user_config/domain/analytics/user_config_events.dart';
import 'package:mobile_app/src/features/user_config/domain/repository/user_config_repository.dart';

@lazySingleton
class SetEnvironmentUseCase extends UseCase<void, String> {
  final UserConfigRepository _repo;

  SetEnvironmentUseCase(this._repo);

  @override
  FutureEither<void> call(String environment) => _repo
      .setEnvironment(environment)
      .then(
        (result) => result.fold(
          (failure) {
            unawaited(
              Analytics.track(
                SetEnvironmentUseCaseEvent.failure(
                  properties: {
                    AnalyticsPropertyKeys.failureMessage: failure.message,
                    AnalyticsPropertyKeys.failureType: failure.type.name,
                    AnalyticsPropertyKeys.failureSource: failure.source,
                  },
                ),
              ),
            );
            return result;
          },
          (success) {
            unawaited(Analytics.track(SetEnvironmentUseCaseEvent.success()));
            return result;
          },
        ),
      );
}
