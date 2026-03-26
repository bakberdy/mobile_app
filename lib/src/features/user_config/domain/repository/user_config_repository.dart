import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/user_config/domain/entity/app_theme_mode.dart';

abstract class UserConfigRepository {
  FutureEither<void> setTheme(AppThemeMode themeMode);
  FutureEither<AppThemeMode?> getAppThemeMode();
  FutureEither<void> setLocale(String locale);
  FutureEither<String?> getLocale();
}