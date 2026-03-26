// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get errorTitle => 'Қате';

  @override
  String get apiFailureDefaultMessage => 'Сұрау кезінде қате орын алды';

  @override
  String get parseFailureDefaultMessage =>
      'Деректерді өңдеу кезінде қате орын алды';

  @override
  String get baseDefaultMessage => 'Күтпеген қате орын алды';

  @override
  String get themeMode => 'Тема режимі';

  @override
  String get light => 'Жарық';

  @override
  String get dark => 'Қара';

  @override
  String get system => 'Жүйелік';

  @override
  String get kazakh => 'Қазақ';

  @override
  String get russian => 'Орыс';

  @override
  String get english => 'Ағылшын';

  @override
  String get notSelected => 'Таңдалмаған';

  @override
  String get dismiss => 'Жабу';
}
