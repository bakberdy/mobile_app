part of 'theme_bloc.dart';

@freezed
sealed class ThemeState with _$ThemeState {
  const factory ThemeState({
    AppThemeMode? themeMode,
    AppThemeMode? systemThemeMode,
    AppThemeMode? appliedThemeMode,
    @Default(StateStatus.initial) StateStatus status,
    String? errorMessage,
  }) = _ThemeState;
}
