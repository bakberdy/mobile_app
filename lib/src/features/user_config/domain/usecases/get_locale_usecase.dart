import 'package:injectable/injectable.dart';
import 'package:travel_app/src/core/monitoring/analytics/analytics.dart';
import 'package:travel_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:travel_app/src/core/usecases/use_case.dart';
import 'package:travel_app/src/core/utils/typedef.dart';
import 'package:travel_app/src/features/user_config/domain/analytics/user_config_events.dart';
import 'package:travel_app/src/features/user_config/domain/repository/user_config_repository.dart';

@LazySingleton()
class GetLocaleUsecase extends UseCase<String?, NoParams> {
  final UserConfigRepository _repo;

  GetLocaleUsecase(this._repo);

  @override
  FutureEither<String?> call(NoParams params) async {
    final result = await _repo.getLocale();
    return result.fold(
      (failure) {
        Analytics.track(
          GetAppLocaleUsecaseEvent.failure(
            properties: {
              AnalyticsPropertyKeys.failureMessage: failure.message,
              AnalyticsPropertyKeys.failureType: failure.type.name,
              AnalyticsPropertyKeys.failureSource: failure.source,
            },
          ),
        );
        return result;
      },
      (success) {
        Analytics.track(GetAppLocaleUsecaseEvent.success());
        return result;
      },
    );
  }
}
