import 'api_options.dart';

class ApiRequest {
  final String path;
  final String method;
  final Object? data;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;
  final ApiOptions? options;

  const ApiRequest({
    required this.path,
    required this.method,
    this.data,
    this.queryParameters,
    this.headers,
    this.options,
  });
}
