
class AppConfig {
  // Compile-time environment values injected via --dart-define / --dart-define-from-file.
  static const String _baseUrl = String.fromEnvironment(
    'base_api_url',
    defaultValue: 'not-provided',
  );
  static const String _environment = String.fromEnvironment(
    'environment',
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
    environment: _environment,
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
