
import 'package:app_log/app_log.dart';
import 'package:travel_app/src/core/monitoring/crashlytics/crashlytics_provider.dart';


class ConsoleCrashProvider implements CrashlyticsProvider {
  String? _userId;

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    Map<String, dynamic>? data,
  }) async {
    final parts = <String>[];
    
    if (reason != null) {
      parts.add('Reason: $reason');
    }
    
    if (_userId != null) {
      parts.add('User: $_userId');
    }
    
    if (data != null && data.isNotEmpty) {
      parts.add('Data: $data');
    }
    
    final message = parts.isEmpty 
        ? 'Crash recorded: $exception'
        : 'Crash recorded: $exception (${parts.join(', ')})';

    appLog(
      message,
      name: 'Crashlytics',
      error: exception,
      stackTrace: stackTrace,
    );
  }

  @override
  Future<void> log(String message) async {
    appLog(
      'Crashlytics: $message',
      name: 'Crashlytics',
    );
  }

  @override
  Future<void> setUserId(String userId) async {
    _userId = userId;
    appLog(
      'Crashlytics user set: $userId',
      name: 'Crashlytics',
    );
  }

  @override
  Future<void> clearUserId() async {
    _userId = null;
    appLog(
      'Crashlytics user cleared',
      name: 'Crashlytics',
    );
  }
}
