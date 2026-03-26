import 'package:app_log/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/app.dart';
import 'package:mobile_app/app_config.dart';
import 'package:mobile_app/src/config/di/injection.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics.dart';
import 'package:mobile_app/src/core/monitoring/analytics/analytics_events.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  AppLogConfig.init();
  // Crashlytics.initialize([
  //   ConsoleCrashProvider(),
  // ], enableCrashlytics: AppConfig.instance.enableCrashlytics);
  // Analytics.initialize([
  //   ConsoleAnalyticsProvider(),
  // ], enableAnalytics: AppConfig.instance.enableAnalytics);
  Bloc.observer = BlocLogObserver();

  Analytics.track(AnalyticsEvent(name: AnalyticsEventNames.appOpened));
  final config = AppConfig.instance;
  appLog('App started');
  appLog('environment: ${config.environment}');
  appLog('base_api_url: ${config.baseUrl}');

  runApp(const App());
}
