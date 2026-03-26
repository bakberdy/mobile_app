


import 'package:app_log/app_log.dart';

import '../analytics.dart';
import '../analytics_events.dart';

/// Console Analytics provider for development/debugging
class ConsoleAnalyticsProvider implements AnalyticsProvider {
  @override
  Future<void> track(AnalyticsEvent event) async {
    appLog(
      'Event tracked: ${event.name}',
      name: 'Analytics',
    );
    if (event.properties != null) {
      appLog(
        '   Properties: ${event.properties}',  
        name: 'Analytics',
      );
    }
  }

  @override
  Future<void> setUserId(String? userId) async {
    appLog(
      'User ID set: $userId',
      name: 'Analytics',
    );
  }

  @override
  Future<void> setUserProperty(Map<String, dynamic> properties) async {
    appLog(
      'User property set: $properties',
      name: 'Analytics',
    );
  }
}
