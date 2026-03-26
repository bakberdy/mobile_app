import 'dart:async';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/src/core/bloc/state_status.dart';
import 'package:travel_app/src/core/error/error.dart';
import 'package:travel_app/src/core/usecases/use_case.dart';
import 'package:travel_app/src/core/utils/constants/locale_constants.dart';
import 'package:travel_app/src/features/user_config/domain/usecases/get_locale_usecase.dart';
import 'package:travel_app/src/features/user_config/domain/usecases/set_locale_usecase.dart';

part 'locale_event.dart';
part 'locale_state.dart';
part 'locale_bloc.freezed.dart';

@Injectable()
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final GetLocaleUsecase _getLocaleUsecase;
  final SetLocaleUsecase _setLocaleUsecase;
  static const List<Locale> _supportedLanguageCodes = LocaleConstants.supportedLocales;

  LocaleBloc(this._getLocaleUsecase, this._setLocaleUsecase)
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

  Future<void> _onStarted(LocaleStarted event, Emitter<LocaleState> emit) async {
    emit(state.copyWith(status: StateStatus.loading, errorMessage: null));

    final result = await _getLocaleUsecase(const NoParams());

    result.fold(
      (Failure failure) {
        emit(
          state.copyWith(
            status: StateStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (languageCode) async {
        if (languageCode != null) {
          emit(
            state.copyWith(
              languageCode: languageCode,
              status: StateStatus.success,
              errorMessage: null,
            ),
          );
        } else {
          // First launch: nothing stored yet — persist and emit device locale.
          await _setLocaleUsecase(SetLocaleUsecaseParams(locale: event.deviceLanguageCode));
          emit(
            state.copyWith(
              languageCode: event.deviceLanguageCode,
              status: StateStatus.success,
              errorMessage: null,
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
    if (!_supportedLanguageCodes.any((locale) => locale.languageCode == event.languageCode)) {
      return;
    }

    emit(
      state.copyWith(
        languageCode: event.languageCode,
        status: StateStatus.loading,
        errorMessage: null,
      ),
    );

    final result = await _setLocaleUsecase(
      SetLocaleUsecaseParams(locale: event.languageCode),
    );

    result.fold(
      (Failure failure) {
        emit(
          state.copyWith(
            status: StateStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        emit(state.copyWith(status: StateStatus.success));
      },
    );
  }
}
