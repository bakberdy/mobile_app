part of 'locale_bloc.dart';

@freezed
sealed class LocaleEvent with _$LocaleEvent {
  const factory LocaleEvent.started({required String deviceLanguageCode}) =
      LocaleStarted;

  const factory LocaleEvent.changed(String languageCode) = LocaleChanged;
}
