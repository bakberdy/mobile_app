import 'package:mobile_app/src/core/api/api.dart';

 class ApiException implements Exception {
  final ApiExceptionType type;
  final ApiResponse? response;

  const ApiException({required this.type, this.response});
}


enum ApiExceptionType {
  cancel,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  connectionError,
  badCertificate,
  badResponse,
  unknown,
}
