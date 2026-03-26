// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get errorTitle => 'Ошибка';

  @override
  String get apiFailureDefaultMessage => 'Что-то пошло не так при запросе';

  @override
  String get parseFailureDefaultMessage => 'Ошибка при обработке данных';

  @override
  String get baseDefaultMessage => 'Произошла непредвиденная ошибка';

  @override
  String get themeMode => 'Режим темы';

  @override
  String get light => 'Светлый';

  @override
  String get dark => 'Темный';

  @override
  String get system => 'Системный';

  @override
  String get kazakh => 'Казахский';

  @override
  String get russian => 'Русский';

  @override
  String get english => 'Английский';

  @override
  String get notSelected => 'Не выбрано';

  @override
  String get dismiss => 'Закрыть';
}
