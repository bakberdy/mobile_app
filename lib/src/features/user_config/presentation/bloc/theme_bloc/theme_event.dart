part of 'theme_bloc.dart';

@freezed
sealed class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.started(AppThemeMode systemThemeMode) = ThemeStarted;

  const factory ThemeEvent.modeChanged(AppThemeMode mode) = ThemeModeChanged;

  const factory ThemeEvent.systemRefreshed(AppThemeMode systemThemeMode) =
      ThemeSystemRefreshed;
}
