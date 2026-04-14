import 'package:dio/dio.dart';
import 'package:mobile_app/src/core/api/api.dart';

extension DioExceptionX on DioException {
  ApiException toApiException() => ApiException(
    type: type.toApiExceptionType(),
    response: response?.toApiResponse(),
  );
}

extension DioExceptionTypeX on DioExceptionType {
  ApiExceptionType toApiExceptionType() => switch (this) {
    .badCertificate => .badCertificate,
    .badResponse => .badCertificate,
    .cancel => .cancel,
    .connectionError => .connectionError,
    .receiveTimeout => .receiveTimeout,
    .sendTimeout => .sendTimeout,
    .unknown => .unknown,
    .connectionTimeout => .connectionTimeout,
  };
}

extension DioResponseX on Response {
  ApiResponse<T> toApiResponse<T>() => ApiResponse<T>(
    data: data,
    statusCode: statusCode ?? 0,
    statusMessage: statusMessage,
    headers: headers.map.map((key, values) => MapEntry(key, values.join(', '))),
    request: ApiRequest(
      path: requestOptions.path,
      method: requestOptions.method,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      headers: requestOptions.headers,
    ),
  );
}

extension ApiOptionsX on ApiOptions {
  Options? toOptions() => Options(
    headers: headers,
    contentType: contentType,
    sendTimeout: sendTimeout,
    receiveTimeout: receiveTimeout,
    extra: extra,
    followRedirects: followRedirects,
    maxRedirects: maxRedirects,
  );
}

extension OptionsX on Options {
  ApiOptions? toApiOptions() => ApiOptions(
    headers: headers,
    contentType: contentType,
    sendTimeout: sendTimeout,
    receiveTimeout: receiveTimeout,
    extra: extra,
    followRedirects: followRedirects,
    maxRedirects: maxRedirects,
  );
}

extension CancelTokenX on ApiCancelToken {
  CancelToken? toCancelToken() => nativeCancelToken;
}
