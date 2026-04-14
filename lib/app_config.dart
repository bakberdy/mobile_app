

class AppConfig {
  static const String _baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'not-provided',
  );
  static const String _environmentFromDefine = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'not-provided',
  );

  final String environment;
  final bool enableLogging;
  final bool enableAnalytics;
  final bool enableCrashlytics;
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;

  static final AppConfig instance = AppConfig._internal(
    baseUrl: _baseUrl,
    environment: _environmentFromDefine,
    enableLogging: true,
    enableAnalytics: true,
    enableCrashlytics: true,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  );

  AppConfig._internal({
    required this.baseUrl,
    required this.environment,
    required this.enableLogging,
    required this.enableAnalytics,
    required this.enableCrashlytics,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
  });
}
