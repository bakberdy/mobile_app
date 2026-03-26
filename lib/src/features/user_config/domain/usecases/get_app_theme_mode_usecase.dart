import 'package:injectable/injectable.dart';
import 'package:travel_app/src/core/monitoring/analytics/analytics.dart';
import 'package:travel_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:travel_app/src/core/usecases/use_case.dart';
import 'package:travel_app/src/core/utils/typedef.dart';
import 'package:travel_app/src/features/user_config/domain/analytics/user_config_events.dart';
import 'package:travel_app/src/features/user_config/domain/entity/app_theme_mode.dart';
import 'package:travel_app/src/features/user_config/domain/repository/user_config_repository.dart';

@LazySingleton()
class GetAppThemeModeUsecase extends UseCase<AppThemeMode?, NoParams> {
  final UserConfigRepository _repo;

  GetAppThemeModeUsecase(this._repo);

  @override
  FutureEither<AppThemeMode?> call(NoParams params) async {
    final result = await _repo.getAppThemeMode();
    return result.fold(
      (failure) {
        Analytics.track(
          GetAppThemeModeUsecaseEvent.failure(
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
        Analytics.track(GetAppThemeModeUsecaseEvent.success());
        return result;
      },
    );
  }
}
