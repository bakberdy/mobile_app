import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';

final class GetAppThemeModeUseCaseEvent extends AnalyticsEvent {
  const GetAppThemeModeUseCaseEvent({required super.name, super.properties});

  factory GetAppThemeModeUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => GetAppThemeModeUseCaseEvent(
    name: 'get_app_theme_mode_usecase_success',
    properties: properties,
  );

  factory GetAppThemeModeUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetAppThemeModeUseCaseEvent(
    name: 'get_app_theme_mode_usecase_failure',
    properties: properties,
  );
}

final class GetAppLocaleUseCaseEvent extends AnalyticsEvent {
  const GetAppLocaleUseCaseEvent({required super.name, super.properties});

  factory GetAppLocaleUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => GetAppLocaleUseCaseEvent(
    name: 'get_app_locale_usecase_success',
    properties: properties,
  );

  factory GetAppLocaleUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetAppLocaleUseCaseEvent(
    name: 'get_app_locale_usecase_failure',
    properties: properties,
  );
}

final class SetAppThemeModeUseCaseEvent extends AnalyticsEvent {
  const SetAppThemeModeUseCaseEvent({required super.name, super.properties});

  factory SetAppThemeModeUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => SetAppThemeModeUseCaseEvent(
    name: 'set_app_theme_mode_usecase_success',
    properties: properties,
  );

  factory SetAppThemeModeUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => SetAppThemeModeUseCaseEvent(
    name: 'set_app_theme_mode_usecase_failure',
    properties: properties,
  );
}

final class SetAppLocaleUseCaseEvent extends AnalyticsEvent {
  const SetAppLocaleUseCaseEvent({required super.name, super.properties});

  factory SetAppLocaleUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => SetAppLocaleUseCaseEvent(
    name: 'set_app_locale_usecase_success',
    properties: properties,
  );

  factory SetAppLocaleUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => SetAppLocaleUseCaseEvent(
    name: 'set_app_locale_usecase_failure',
    properties: properties,
  );
}

final class SetEnvironmentUseCaseEvent extends AnalyticsEvent {
  const SetEnvironmentUseCaseEvent({required super.name, super.properties});

  factory SetEnvironmentUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => SetEnvironmentUseCaseEvent(
    name: 'set_environment_use_case_success',
    properties: properties,
  );

  factory SetEnvironmentUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => SetEnvironmentUseCaseEvent(
    name: 'set_environment_use_case_failure',
    properties: properties,
  );
}

final class GetEnvironmentUseCaseEvent extends AnalyticsEvent {
  const GetEnvironmentUseCaseEvent({required super.name, super.properties});

  factory GetEnvironmentUseCaseEvent.success({
    Map<String, dynamic>? properties,
  }) => GetEnvironmentUseCaseEvent(
    name: 'get_environment_use_case_success',
    properties: properties,
  );

  factory GetEnvironmentUseCaseEvent.failure({
    required Map<String, dynamic> properties,
  }) => GetEnvironmentUseCaseEvent(
    name: 'get_environment_use_case_failure',
    properties: properties,
  );
}
