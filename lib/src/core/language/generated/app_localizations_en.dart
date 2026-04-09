// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get addTodo => 'Add Todo';

  @override
  String get apiFailureDefaultMessage => 'Something went wrong on request';

  @override
  String appVersionWithBuild(String version, String buildNumber) {
    return 'Version $version ($buildNumber)';
  }

  @override
  String get baseDefaultMessage => 'An unexpected error occurred';

  @override
  String get clearForm => 'Clear form';

  @override
  String get continueToLogin => 'Continue to Login';

  @override
  String get createdAtLabel => 'Created At';

  @override
  String get createTodo => 'Create todo';

  @override
  String get dark => 'Dark';

  @override
  String get deleteTodo => 'Delete todo';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get editTodo => 'Edit todo';

  @override
  String get english => 'English';

  @override
  String get errorTitle => 'Error';

  @override
  String get exampleTodosTitle => 'Todo Example';

  @override
  String get kazakh => 'Kazakh';

  @override
  String get light => 'Light';

  @override
  String get markTodoDone => 'Mark as done';

  @override
  String get markTodoUndone => 'Mark as not done';

  @override
  String get noTodosYet => 'No todos yet';

  @override
  String get notSelected => 'Not Selected';

  @override
  String get parseFailureDefaultMessage =>
      'Something went wrong on handling the data';

  @override
  String get refreshTodos => 'Refresh todos';

  @override
  String get requiredField => 'This field is required';

  @override
  String get russian => 'Russian';

  @override
  String get santoniLuxuryFurnitureDescription =>
      'Welcome to Santoni Luxury Furniture, your one-stop destination for premium furniture. Explore our curated collection of stylish and elegant pieces.';

  @override
  String get santoniLuxuryFurnitureTitle => 'Santoni Luxury Furniture';

  @override
  String get system => 'System';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get todoDescriptionLabel => 'Description';

  @override
  String get todoDoneLabel => 'Done';

  @override
  String get todoFormTitle => 'Todo form';

  @override
  String get todoListTitle => 'Todo list';

  @override
  String get todoTitleLabel => 'Title';

  @override
  String get updateTodo => 'Update todo';
}
