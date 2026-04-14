import 'dart:async';

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
  Bloc.observer = const BlocLogObserver();

  unawaited(
    Analytics.track(const AnalyticsEvent(name: AnalyticsEventNames.appOpened)),
  );
  final config = AppConfig.instance;
  appLog('App started');
  appLog('ENVIRONMENT: ${config.environment}');
  appLog('API_URL: ${config.baseUrl}');

  runApp(const App());
}
