import 'package:dio/dio.dart';

import '../internal/auth_interceptor.dart';
import '../internal/extensions.dart';
import '../models/api_cancel_token.dart';
import '../models/api_options.dart';
import '../models/api_progress_callback.dart';
import '../models/api_response.dart';
import '../storage/token_storage.dart';
import 'api_config.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient(
    ApiConfig config,
    TokenStorage tokenStorage, {
    List<Interceptor> interceptors = const [],
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        receiveTimeout: config.receiveTimeout,
        sendTimeout: config.sendTimeout,
        headers: config.defaultHeaders,
      ),
    );
    if (config.enableAuthInterceptor) {
      _dio.interceptors.add(
        AuthInterceptor(
          _dio,
          tokenStorage,
          publicPaths: config.publicPaths,
          refreshPath: config.refreshPath,
          logger: config.logger != null
              ? (msg) => config.logger!(msg, name: 'api/auth')
              : null,
        ),
      );
    }

    _dio.interceptors.addAll(interceptors);

    config.logger?.call(
      'ApiClient created → ${config.baseUrl}',
      name: 'api/client',
    );
  }

  Future<ApiResponse<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
    ApiProgressCallback? onReceiveProgress,
  }) => _send(
    () => _dio.get<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<ApiResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
    ApiProgressCallback? onSendProgress,
    ApiProgressCallback? onReceiveProgress,
  }) => _send(
    () => _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<ApiResponse<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
    ApiProgressCallback? onSendProgress,
    ApiProgressCallback? onReceiveProgress,
  }) => _send(
    () => _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<ApiResponse<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
    ApiProgressCallback? onSendProgress,
    ApiProgressCallback? onReceiveProgress,
  }) => _send(
    () => _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    ),
  );

  Future<ApiResponse<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
  }) => _send(
    () => _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
    ),
  );

  Future<ApiResponse<T>> head<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ApiOptions? options,
    ApiCancelToken? cancelToken,
  }) => _send(
    () => _dio.head<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options?.toOptions(),
      cancelToken: cancelToken?.toCancelToken(),
    ),
  );

  Future<ApiResponse> download(
    String urlPath,
    dynamic savePath, {
    ApiProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    ApiCancelToken? cancelToken,
    bool deleteOnError = true,
    Object? data,
    ApiOptions? options,
  }) => _send(
    () => _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken?.toCancelToken(),
      deleteOnError: deleteOnError,
      data: data,
      options: options?.toOptions(),
    ),
  );

  // ── Internal ────────────────────────────────────────────────────────────────

  Future<ApiResponse<T>> _send<T>(Future<Response<T>> Function() call) async {
    try {
      final response = await call();
      return response.toApiResponse<T>();
    } on DioException catch (e) {
      throw e.toApiException();
    } catch (e) {
      rethrow;
    }
  }
}
