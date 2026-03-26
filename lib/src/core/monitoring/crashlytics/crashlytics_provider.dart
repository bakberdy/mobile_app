abstract class CrashlyticsProvider {
  Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    Map<String, dynamic>? data,
  });
  Future<void> log(String message);
  Future<void> setUserId(String userId);
  Future<void> clearUserId();
}