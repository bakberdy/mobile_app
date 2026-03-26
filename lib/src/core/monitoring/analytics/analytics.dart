import 'analytics_events.dart';

abstract class AnalyticsProvider {
  Future<void> track(AnalyticsEvent event);
  Future<void> setUserId(String? userId);
  Future<void> setUserProperty(Map<String, dynamic> properties);
}

class Analytics {
  static List<AnalyticsProvider> _providers = [];
  static bool _enableAnalytics = true;

  static void initialize(List<AnalyticsProvider> providers, {bool enableAnalytics = true}) {
    _providers = providers;
    _enableAnalytics = enableAnalytics;
  }

  static Future<void> track(AnalyticsEvent event) async {
    if (!_enableAnalytics) return;
    await Future.wait(
      _providers.map((provider) => provider.track(event)),
    );
  }

  static Future<void> setUserId(String? userId) async {
    if (!_enableAnalytics) return;
    await Future.wait(
      _providers.map((provider) => provider.setUserId(userId)),
    );
  }

  static Future<void> setUserProperty(Map<String, dynamic> properties) async {
    if (!_enableAnalytics) return;
    await Future.wait(
      _providers.map((provider) => provider.setUserProperty(properties)),
    );
  }
}