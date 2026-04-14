import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/app_config.dart';
import 'package:mobile_app/src/config/router/app_router.dart';
import 'package:mobile_app/src/config/router/auth_guard.dart';
import 'package:mobile_app/src/core/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  @singleton
  AppConfig get appConfig => AppConfig.instance;

  @singleton
  Connectivity get connectivity => Connectivity();

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences async =>
      await SharedPreferences.getInstance();

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @singleton
  TokenStorage tokenStorage(FlutterSecureStorage secureStorage) =>
      TokenStorageImpl(secureStorage);

  @singleton
  AuthGuard authGuard(TokenStorage tokenStorage) =>
      AuthGuard(tokenStorage: tokenStorage);

  @singleton
  AppRouter appRouter(AuthGuard authGuard) => AppRouter(authGuard: authGuard);

  @lazySingleton
  ApiClient apiClient(TokenStorage tokenStorage, AppConfig appConfig) =>
      ApiClient(
        ApiConfig(
          baseUrl: appConfig.baseUrl,
          connectTimeout: appConfig.connectTimeout,
          receiveTimeout: appConfig.receiveTimeout,
          sendTimeout: appConfig.sendTimeout,
        ),
        tokenStorage,
      );
}
