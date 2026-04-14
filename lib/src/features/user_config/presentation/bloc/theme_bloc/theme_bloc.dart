import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/bloc/state_status/state_status.dart';
import 'package:mobile_app/src/core/error/error.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/features/user_config/domain/entity/app_theme_mode.dart';
import 'package:mobile_app/src/features/user_config/domain/usecases/get_app_theme_mode_use_case.dart';
import 'package:mobile_app/src/features/user_config/domain/usecases/set_theme_use_case.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

AppThemeMode _resolveAppliedThemeMode(
  AppThemeMode? themeMode,
  AppThemeMode? systemThemeMode,
) {
  switch (themeMode) {
    case AppThemeMode.system:
    case null:
      return systemThemeMode ?? AppThemeMode.light;
    case AppThemeMode.light:
    case AppThemeMode.dark:
      return themeMode;
  }
}

@Injectable()
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetAppThemeModeUseCase _getAppThemeModeUseCase;
  final SetThemeUseCase _setThemeUseCase;

  ThemeBloc(this._getAppThemeModeUseCase, this._setThemeUseCase)
    : super(ThemeState()) {
    on<ThemeStarted>(_onStarted);
    on<ThemeModeChanged>(_onModeChanged);
    on<ThemeSystemRefreshed>(_onSystemRefreshed);
  }

  void setThemeMode(AppThemeMode mode) {
    add(ThemeEvent.modeChanged(mode));
  }

  void start({required AppThemeMode systemThemeMode}) {
    add(ThemeEvent.started(systemThemeMode));
  }

  void applySystemThemeMode(AppThemeMode systemThemeMode) {
    add(ThemeEvent.systemRefreshed(systemThemeMode));
  }

  Future<void> _onStarted(ThemeStarted event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(status: StateStatus.loading()));

    final result = await _getAppThemeModeUseCase(const NoParams());

    await result.fold<Future<void>>(
      (Failure failure) async {
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (AppThemeMode? appThemeMode) async {
        if (appThemeMode != null) {
          emit(
            state.copyWith(
              themeMode: appThemeMode,
              systemThemeMode: event.systemThemeMode,
              appliedThemeMode: _resolveAppliedThemeMode(
                appThemeMode,
                event.systemThemeMode,
              ),
              status: StateStatus.success(),
            ),
          );
        } else {
          await _setThemeUseCase(
            const SetThemeUseCaseParams(themeMode: AppThemeMode.system),
          );
          if (emit.isDone) {
            return;
          }
          emit(
            state.copyWith(
              themeMode: AppThemeMode.system,
              systemThemeMode: event.systemThemeMode,
              appliedThemeMode: _resolveAppliedThemeMode(
                AppThemeMode.system,
                event.systemThemeMode,
              ),
              status: StateStatus.success(),
            ),
          );
        }
      },
    );
  }

  Future<void> _onModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(
      state.copyWith(
        themeMode: event.mode,
        systemThemeMode: state.systemThemeMode,
        appliedThemeMode: _resolveAppliedThemeMode(
          event.mode,
          state.systemThemeMode,
        ),
        status: StateStatus.loading(),
      ),
    );

    final result = await _setThemeUseCase(
      SetThemeUseCaseParams(themeMode: event.mode),
    );

    result.fold(
      (Failure failure) {
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (_) {
        emit(state.copyWith(status: StateStatus.success()));
      },
    );
  }

  void _onSystemRefreshed(
    ThemeSystemRefreshed event,
    Emitter<ThemeState> emit,
  ) {
    final hasSystemModeChanged = event.systemThemeMode != state.systemThemeMode;
    if (!hasSystemModeChanged && state.themeMode != AppThemeMode.system) {
      return;
    }

    final appliedThemeMode = _resolveAppliedThemeMode(
      state.themeMode,
      event.systemThemeMode,
    );
    if (!hasSystemModeChanged && appliedThemeMode == state.appliedThemeMode) {
      return;
    }

    emit(
      state.copyWith(
        systemThemeMode: event.systemThemeMode,
        appliedThemeMode: appliedThemeMode,
        status: StateStatus.success(),
      ),
    );
  }
}
