// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errorTitle => 'Error';

  @override
  String get apiFailureDefaultMessage => 'Something went wrong on request';

  @override
  String get parseFailureDefaultMessage =>
      'Something went wrong on handling the data';

  @override
  String get baseDefaultMessage => 'An unexpected error occurred';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get kazakh => 'Kazakh';

  @override
  String get russian => 'Russian';

  @override
  String get english => 'English';

  @override
  String get notSelected => 'Not Selected';

  @override
  String get dismiss => 'Dismiss';
}
