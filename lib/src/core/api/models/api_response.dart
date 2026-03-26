import 'api_request.dart';

class ApiResponse<T> {
  final T? data;
  final int statusCode;
  final String? statusMessage;
  final Map<String, dynamic> headers;
  final ApiRequest? request;

  const ApiResponse({
    this.data,
    required this.statusCode,
    this.statusMessage,
    this.headers = const {},
    this.request,
  });


  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
}
