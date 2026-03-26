import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/user_config/domain/analytics/user_config_events.dart';
import 'package:mobile_app/src/features/user_config/domain/repository/user_config_repository.dart';

class SetLocaleUsecaseParams {
  final String locale;

  const SetLocaleUsecaseParams({required this.locale});
}

@LazySingleton()
class SetLocaleUsecase extends UseCase<void, SetLocaleUsecaseParams> {
  final UserConfigRepository _repo;

  SetLocaleUsecase(this._repo);

  @override
  FutureEither<void> call(SetLocaleUsecaseParams params) {
    return _repo.setLocale(params.locale).then(
      (result) {
        return result.fold(
          (failure) {
            Analytics.track(SetAppLocaleUsecaseEvent.failure(properties: {
              AnalyticsPropertyKeys.failureMessage: failure.message,
              AnalyticsPropertyKeys.failureType: failure.type.name,
              AnalyticsPropertyKeys.failureSource: failure.source,
            }));
            return result;
          },
          (success) {
            Analytics.track(SetAppLocaleUsecaseEvent.success());
            return result;
          },
        );
      },
    );
  }
}
