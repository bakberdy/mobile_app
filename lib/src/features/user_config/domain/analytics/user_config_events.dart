import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';

final class GetAppThemeModeUsecaseEvent extends AnalyticsEvent {
  const GetAppThemeModeUsecaseEvent({required super.name, super.properties});

   factory GetAppThemeModeUsecaseEvent.success({
    Map<String, dynamic>? properties,
  }) => GetAppThemeModeUsecaseEvent(
    name: 'get_app_theme_mode_usecase_success',
    properties: properties,
  );

  factory GetAppThemeModeUsecaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetAppThemeModeUsecaseEvent(
    name: 'get_app_theme_mode_usecase_failure',
    properties: properties,
  );
}

final class GetAppLocaleUsecaseEvent extends AnalyticsEvent {
  const GetAppLocaleUsecaseEvent({required super.name, super.properties});

  factory GetAppLocaleUsecaseEvent.success({
    Map<String, dynamic>? properties,
  }) => GetAppLocaleUsecaseEvent(
    name: 'get_app_locale_usecase_success',
    properties: properties,
  );

  factory GetAppLocaleUsecaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetAppLocaleUsecaseEvent(
    name: 'get_app_locale_usecase_failure',
    properties: properties,
  );
}


final class SetAppThemeModeUsecaseEvent extends AnalyticsEvent {
  const SetAppThemeModeUsecaseEvent({required super.name, super.properties});

  factory SetAppThemeModeUsecaseEvent.success({
    Map<String, dynamic>? properties,
  }) => SetAppThemeModeUsecaseEvent(
    name: 'set_app_theme_mode_usecase_success',
    properties: properties,
  );

  factory SetAppThemeModeUsecaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => SetAppThemeModeUsecaseEvent(
    name: 'set_app_theme_mode_usecase_failure',
    properties: properties,
  );
}

final class SetAppLocaleUsecaseEvent extends AnalyticsEvent {
  const SetAppLocaleUsecaseEvent({required super.name, super.properties});

  factory SetAppLocaleUsecaseEvent.success({
    Map<String, dynamic>? properties,
  }) => SetAppLocaleUsecaseEvent(
    name: 'set_app_locale_usecase_success',
    properties: properties,
  );

  factory SetAppLocaleUsecaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => SetAppLocaleUsecaseEvent(
    name: 'set_app_locale_usecase_failure',
    properties: properties,
  );
}