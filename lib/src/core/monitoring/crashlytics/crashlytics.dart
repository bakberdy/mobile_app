

import 'package:mobile_app/src/core/monitoring/crashlytics/crashlytics_provider.dart';

class Crashlytics {
  static List<CrashlyticsProvider> _providers = [];
  static bool _enableCrashlytics = true;

  static void initialize(
    List<CrashlyticsProvider> providers, {
    bool enableCrashlytics = true,
  }) {
    _providers = providers;
    _enableCrashlytics = enableCrashlytics;
  }

  static Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    Map<String, dynamic>? data,
  }) async {
    if (!_enableCrashlytics) return;
    await Future.wait(
      _providers.map(
        (provider) => provider.recordError(
          exception,
          stackTrace,
          reason: reason,
          data: data,
        ),
      ),
    );
  }

  static Future<void> log(String message) async {
    if (!_enableCrashlytics) return;
    await Future.wait(_providers.map((provider) => provider.log(message)));
  }

  static Future<void> setUserId(String userId) async {
    if (!_enableCrashlytics) return;
    await Future.wait(_providers.map((provider) => provider.setUserId(userId)));
  }

  static Future<void> clearUserId() async {
    if (!_enableCrashlytics) return;
    await Future.wait(_providers.map((provider) => provider.clearUserId()));
  }
}
