import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/user_config/domain/analytics/user_config_events.dart';
import 'package:mobile_app/src/features/user_config/domain/entity/app_theme_mode.dart';
import 'package:mobile_app/src/features/user_config/domain/repository/user_config_repository.dart';

class SetThemeUseCaseParams {
  final AppThemeMode themeMode;

  const SetThemeUseCaseParams({required this.themeMode});
}

@LazySingleton()
class SetThemeUseCase extends UseCase<void, SetThemeUseCaseParams> {
  final UserConfigRepository _repo;

  SetThemeUseCase(this._repo);

  @override
  FutureEither<void> call(SetThemeUseCaseParams params) {
    return _repo.setTheme(params.themeMode).then(
      (result) {
        return result.fold(
          (failure) {
            Analytics.track(SetAppThemeModeUseCaseEvent.failure(properties: {
              AnalyticsPropertyKeys.failureMessage: failure.message,
              AnalyticsPropertyKeys.failureType: failure.type.name,
              AnalyticsPropertyKeys.failureSource: failure.source,
            }));
            return result;
          },
          (success) {
            Analytics.track(SetAppThemeModeUseCaseEvent.success());
            return result;
          },
        );
      },
    );
  }
}
