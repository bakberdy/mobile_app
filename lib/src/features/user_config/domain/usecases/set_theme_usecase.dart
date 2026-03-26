import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/user_config/domain/analytics/user_config_events.dart';
import 'package:mobile_app/src/features/user_config/domain/entity/app_theme_mode.dart';
import 'package:mobile_app/src/features/user_config/domain/repository/user_config_repository.dart';

class SetThemeUsecaseParams {
  final AppThemeMode themeMode;

  const SetThemeUsecaseParams({required this.themeMode});
}

@LazySingleton()
class SetThemeUsecase extends UseCase<void, SetThemeUsecaseParams> {
  final UserConfigRepository _repo;

  SetThemeUsecase(this._repo);

  @override
  FutureEither<void> call(SetThemeUsecaseParams params) {
    return _repo.setTheme(params.themeMode).then(
      (result) {
        return result.fold(
          (failure) {
            Analytics.track(SetAppThemeModeUsecaseEvent.failure(properties: {
              AnalyticsPropertyKeys.failureMessage: failure.message,
              AnalyticsPropertyKeys.failureType: failure.type.name,
              AnalyticsPropertyKeys.failureSource: failure.source,
            }));
            return result;
          },
          (success) {
            Analytics.track(SetAppThemeModeUsecaseEvent.success());
            return result;
          },
        );
      },
    );
  }
}
