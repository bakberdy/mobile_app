import 'dart:async';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/bloc/state_status/state_status.dart';
import 'package:mobile_app/src/core/error/error.dart';
import 'package:mobile_app/src/core/usecases/use_case.dart';
import 'package:mobile_app/src/core/utils/constants/locale_constants.dart';
import 'package:mobile_app/src/features/user_config/domain/usecases/get_locale_use_case.dart';
import 'package:mobile_app/src/features/user_config/domain/usecases/set_locale_use_case.dart';

part 'locale_event.dart';
part 'locale_state.dart';
part 'locale_bloc.freezed.dart';

@Injectable()
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final GetLocaleUseCase _getLocaleUseCase;
  final SetLocaleUseCase _setLocaleUseCase;
  static const List<Locale> _supportedLanguageCodes =
      LocaleConstants.supportedLocales;

  LocaleBloc(this._getLocaleUseCase, this._setLocaleUseCase)
    : super(const LocaleState()) {
    on<LocaleStarted>(_onStarted);
    on<LocaleChanged>(_onLocaleChanged);
  }

  void setLocale(String languageCode) {
    add(LocaleEvent.changed(languageCode));
  }

  void setLocaleByCode(String languageCode) {
    add(LocaleEvent.changed(languageCode));
  }

  Future<void> _onStarted(
    LocaleStarted event,
    Emitter<LocaleState> emit,
  ) async {
    emit(state.copyWith(status: const StateStatus.loading()));

    final result = await _getLocaleUseCase(const NoParams());

    await result.fold(
      (Failure failure) {
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (languageCode) async {
        if (languageCode != null) {
          emit(
            state.copyWith(
              languageCode: languageCode,
              status: const StateStatus.success(),
            ),
          );
        } else {
          await _setLocaleUseCase(
            SetLocaleUseCaseParams(locale: event.deviceLanguageCode),
          );
          if (emit.isDone) {
            return;
          }
          emit(
            state.copyWith(
              languageCode: event.deviceLanguageCode,
              status: const StateStatus.success(),
            ),
          );
        }
      },
    );
  }

  Future<void> _onLocaleChanged(
    LocaleChanged event,
    Emitter<LocaleState> emit,
  ) async {
    if (!_supportedLanguageCodes.any(
      (locale) => locale.languageCode == event.languageCode,
    )) {
      return;
    }

    emit(
      state.copyWith(
        languageCode: event.languageCode,
        status: const StateStatus.loading(),
      ),
    );

    final result = await _setLocaleUseCase(
      SetLocaleUseCaseParams(locale: event.languageCode),
    );

    result.fold(
      (Failure failure) {
        emit(state.copyWith(status: StateStatus.error(failure)));
      },
      (_) {
        emit(state.copyWith(status: const StateStatus.success()));
      },
    );
  }
}
