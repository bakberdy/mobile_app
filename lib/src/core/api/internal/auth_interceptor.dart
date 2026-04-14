import 'package:dio/dio.dart';

import '../storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final TokenStorage _tokenStorage;
  final void Function(String)? _log;
  final List<String> _publicPaths;
  final String _refreshPath;

  static const _authHeader = 'Authorization';
  static const _bearer = 'Bearer';

  bool _isRefreshing = false;
  Future<void>? _refreshFuture;

  AuthInterceptor(
    this._dio,
    this._tokenStorage, {
    String refreshPath = '/auth/refresh',
    void Function()? onUnauthorized,
    void Function(String)? logger, 
    required List<String> publicPaths,
  })  : _publicPaths = publicPaths,
        _refreshPath = refreshPath,
        _log = logger;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isPublicPath(options.path)) return handler.next(options);

    try {
      final token = await _tokenStorage.getAccessToken();
      if (token != null) {
        options.headers[_authHeader] = '$_bearer $token';
      }
    } catch (_) {}

    return handler.next(options);
  }


  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) return handler.next(err);

    final path = err.requestOptions.path;

    if (path.contains('refresh')) {
      await _handleUnauthorized();
      return handler.reject(_toUnauthorizedError(err));
    }

    if (path.contains('login')) return handler.next(err);

    final hasRefresh = await _tokenStorage.containsRefreshToken();
    if (!hasRefresh) {
      await _handleUnauthorized();
      return handler.reject(_toUnauthorizedError(err));
    }

    try {
      if (!_isRefreshing) {
        _isRefreshing = true;
        _refreshFuture = _doRefresh().whenComplete(() => _isRefreshing = false);
      }
      await _refreshFuture;

      final response = await _retry(err.requestOptions);
      return handler.resolve(response);
    } catch (_) {
      await _handleUnauthorized();
      return handler.reject(_toUnauthorizedError(err));
    }
  }


  Future<void> _doRefresh() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) throw Exception('No refresh token');

    final response = await _dio.post<Map<String, dynamic>>(
      _refreshPath,
      data: {'refresh_token': refreshToken},
      options: Options(headers: {_authHeader: '$_bearer $refreshToken'}),
    );

    if (response.statusCode != 200 || response.data == null) {
      throw Exception('Token refresh failed');
    }

    final newAccess = response.data!['access_token'] as String?;
    final newRefresh = response.data!['refresh_token'] as String?;

    if (newAccess == null) throw Exception('Missing access_token in response');

    await _tokenStorage.saveAccessToken(newAccess);
    if (newRefresh != null) await _tokenStorage.saveRefreshToken(newRefresh);

    _log?.call('Access token refreshed');
  }

  Future<Response> _retry(RequestOptions original) async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) throw Exception('No access token after refresh');

    return _dio.request(
      original.path,
      data: original.data,
      queryParameters: original.queryParameters,
      options: Options(
        method: original.method,
        headers: {...original.headers, _authHeader: '$_bearer $token'},
      ),
    );
  }

  Future<void> _handleUnauthorized() async {
    await _tokenStorage.clearTokens();
  }

  DioException _toUnauthorizedError(DioException source) {
    final response = source.response ??
        Response(
          requestOptions: source.requestOptions,
          statusCode: 401,
          statusMessage: 'Unauthorized',
        );
    return DioException(
      requestOptions: source.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  bool _isPublicPath(String path) => _publicPaths.any(path.contains);
}
