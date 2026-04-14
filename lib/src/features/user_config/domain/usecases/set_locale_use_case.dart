import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/user_config/domain/analytics/user_config_events.dart';
import 'package:mobile_app/src/features/user_config/domain/repository/user_config_repository.dart';

class SetLocaleUseCaseParams {
  final String locale;

  const SetLocaleUseCaseParams({required this.locale});
}

@LazySingleton()
class SetLocaleUseCase extends UseCase<void, SetLocaleUseCaseParams> {
  final UserConfigRepository _repo;

  SetLocaleUseCase(this._repo);

  @override
  FutureEither<void> call(SetLocaleUseCaseParams params) {
    return _repo.setLocale(params.locale).then((result) {
      return result.fold(
        (failure) {
          unawaited(
            Analytics.track(
              SetAppLocaleUseCaseEvent.failure(
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
          unawaited(Analytics.track(SetAppLocaleUseCaseEvent.success()));
          return result;
        },
      );
    });
  }
}
