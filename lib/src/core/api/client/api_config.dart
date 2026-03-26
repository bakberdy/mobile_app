class ApiConfig {
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final Map<String, String> defaultHeaders;
  final List<String> publicPaths;
  final String refreshPath;
  final bool enableAuthInterceptor;
  final void Function(String message, {String name})? logger;

  const ApiConfig({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.sendTimeout = const Duration(seconds: 30),
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    this.publicPaths = const [],
    this.refreshPath = '/auth/refresh',
    this.enableAuthInterceptor = true,
    this.logger,
  });
}
