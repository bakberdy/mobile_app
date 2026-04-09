// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get addTodo => 'Добавить задачу';

  @override
  String get apiFailureDefaultMessage => 'Что-то пошло не так при запросе';

  @override
  String appVersionWithBuild(String version, String buildNumber) {
    return 'Версия $version ($buildNumber)';
  }

  @override
  String get baseDefaultMessage => 'Произошла непредвиденная ошибка';

  @override
  String get clearForm => 'Очистить форму';

  @override
  String get continueToLogin => 'Продолжить вход';

  @override
  String get createdAtLabel => 'Дата создания';

  @override
  String get createTodo => 'Создать задачу';

  @override
  String get dark => 'Темный';

  @override
  String get deleteTodo => 'Удалить задачу';

  @override
  String get dismiss => 'Закрыть';

  @override
  String get editTodo => 'Редактировать задачу';

  @override
  String get english => 'Английский';

  @override
  String get errorTitle => 'Ошибка';

  @override
  String get exampleTodosTitle => 'Пример задач';

  @override
  String get kazakh => 'Казахский';

  @override
  String get light => 'Светлый';

  @override
  String get markTodoDone => 'Отметить как выполненную';

  @override
  String get markTodoUndone => 'Отметить как невыполненную';

  @override
  String get noTodosYet => 'Пока нет задач';

  @override
  String get notSelected => 'Не выбрано';

  @override
  String get parseFailureDefaultMessage => 'Ошибка при обработке данных';

  @override
  String get refreshTodos => 'Обновить задачи';

  @override
  String get requiredField => 'Это поле обязательно';

  @override
  String get russian => 'Русский';

  @override
  String get santoniLuxuryFurnitureDescription =>
      'Добро пожаловать в Santoni Luxury Furniture, ваш универсальный магазин премиальной мебели. Откройте для себя нашу тщательно подобранную коллекцию стильных и элегантных предметов.';

  @override
  String get santoniLuxuryFurnitureTitle => 'Santoni Luxury Furniture';

  @override
  String get system => 'Системный';

  @override
  String get themeMode => 'Режим темы';

  @override
  String get todoDescriptionLabel => 'Описание';

  @override
  String get todoDoneLabel => 'Выполнено';

  @override
  String get todoFormTitle => 'Форма задачи';

  @override
  String get todoListTitle => 'Список задач';

  @override
  String get todoTitleLabel => 'Название';

  @override
  String get updateTodo => 'Обновить задачу';
}
