part of 'locale_bloc.dart';

@freezed
sealed class LocaleState with _$LocaleState {
  const factory LocaleState({
    String? languageCode,
    @Default(StateStatus.initial()) StateStatus status,
  }) = _LocaleState;
}
