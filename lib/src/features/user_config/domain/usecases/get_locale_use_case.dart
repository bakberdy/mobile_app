import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/user_config/domain/analytics/user_config_events.dart';
import 'package:mobile_app/src/features/user_config/domain/repository/user_config_repository.dart';

@LazySingleton()
class GetLocaleUseCase extends UseCase<String?, NoParams> {
  final UserConfigRepository _repo;

  GetLocaleUseCase(this._repo);

  @override
  FutureEither<String?> call(NoParams params) async {
    final result = await _repo.getLocale();
    return result.fold(
      (failure) {
        unawaited(
          Analytics.track(
            GetAppLocaleUseCaseEvent.failure(
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
        unawaited(Analytics.track(GetAppLocaleUseCaseEvent.success()));
        return result;
      },
    );
  }
}
