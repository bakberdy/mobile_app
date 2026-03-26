class ApiOptions {
  final Map<String, dynamic>? headers;
  final String? contentType;
  final Duration? sendTimeout;
  final Duration? receiveTimeout;
  final Map<String, dynamic>? extra;
  final bool? followRedirects;
  final int? maxRedirects;

  const ApiOptions({
    this.headers,
    this.contentType,
    this.sendTimeout,
    this.receiveTimeout,
    this.extra,
    this.followRedirects = true,
    this.maxRedirects = 5,
  });
}
