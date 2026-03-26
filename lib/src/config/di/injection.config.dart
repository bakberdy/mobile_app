// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:travel_app/app_config.dart' as _i613;
import 'package:travel_app/src/config/di/app_module.dart' as _i419;
import 'package:travel_app/src/config/router/app_router.dart' as _i433;
import 'package:travel_app/src/config/router/auth_guard.dart' as _i74;
import 'package:travel_app/src/core/api/api.dart' as _i517;
import 'package:travel_app/src/core/monitoring/observers/analytics_page_observer.dart'
    as _i1002;
import 'package:travel_app/src/core/network/network_info.dart' as _i215;
import 'package:travel_app/src/core/storage/local_storage/local_storage.dart'
    as _i486;
import 'package:travel_app/src/core/storage/local_storage/shared_preferences_storage.dart'
    as _i968;
import 'package:travel_app/src/core/storage/secure_storage/flutter_secure_storage_impl.dart'
    as _i349;
import 'package:travel_app/src/core/storage/secure_storage/secure_storage.dart'
    as _i412;
import 'package:travel_app/src/features/user_config/data/datasource/user_config_local_data_source.dart'
    as _i744;
import 'package:travel_app/src/features/user_config/data/datasource/user_config_remote_data_source.dart'
    as _i88;
import 'package:travel_app/src/features/user_config/data/repository/user_config_repository_impl.dart'
    as _i254;
import 'package:travel_app/src/features/user_config/domain/repository/user_config_repository.dart'
    as _i140;
import 'package:travel_app/src/features/user_config/domain/usecases/get_app_theme_mode_usecase.dart'
    as _i1002;
import 'package:travel_app/src/features/user_config/domain/usecases/get_locale_usecase.dart'
    as _i404;
import 'package:travel_app/src/features/user_config/domain/usecases/set_locale_usecase.dart'
    as _i648;
import 'package:travel_app/src/features/user_config/domain/usecases/set_theme_usecase.dart'
    as _i109;
import 'package:travel_app/src/features/user_config/presentation/bloc/locale_bloc/locale_bloc.dart'
    as _i764;
import 'package:travel_app/src/features/user_config/presentation/bloc/theme_bloc/theme_bloc.dart'
    as _i362;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i613.AppConfig>(() => appModule.appConfig);
    gh.singleton<_i895.Connectivity>(() => appModule.connectivity);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i558.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.lazySingleton<_i1002.AnalyticsPageObserver>(
      () => _i1002.AnalyticsPageObserver(),
    );
    gh.singleton<_i215.NetworkInfo>(
      () => _i215.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.singleton<_i88.UserConfigRemoteDataSource>(
      () => _i88.UserConfigRemoteDataSourceImpl(),
    );
    gh.singleton<_i517.TokenStorage>(
      () => appModule.tokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i412.SecureStorage>(
      () => _i349.FlutterSecureStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i486.LocalStorage>(
      () => _i968.SharedPreferencesStorage(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.singleton<_i744.UserConfigLocalDataSource>(
      () => _i744.UserConfigLocalDataSourceImpl(
        localStorage: gh<_i486.LocalStorage>(),
      ),
    );
    gh.singleton<_i74.AuthGuard>(
      () => appModule.authGuard(gh<_i517.TokenStorage>()),
    );
    gh.lazySingleton<_i517.ApiClient>(
      () =>
          appModule.apiClient(gh<_i517.TokenStorage>(), gh<_i613.AppConfig>()),
    );
    gh.singleton<_i433.AppRouter>(
      () => appModule.appRouter(gh<_i74.AuthGuard>()),
    );
    gh.singleton<_i140.UserConfigRepository>(
      () => _i254.UserConfigRepositoryImpl(
        gh<_i744.UserConfigLocalDataSource>(),
        gh<_i88.UserConfigRemoteDataSource>(),
        gh<_i215.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i1002.GetAppThemeModeUsecase>(
      () => _i1002.GetAppThemeModeUsecase(gh<_i140.UserConfigRepository>()),
    );
    gh.lazySingleton<_i404.GetLocaleUsecase>(
      () => _i404.GetLocaleUsecase(gh<_i140.UserConfigRepository>()),
    );
    gh.lazySingleton<_i648.SetLocaleUsecase>(
      () => _i648.SetLocaleUsecase(gh<_i140.UserConfigRepository>()),
    );
    gh.lazySingleton<_i109.SetThemeUsecase>(
      () => _i109.SetThemeUsecase(gh<_i140.UserConfigRepository>()),
    );
    gh.factory<_i764.LocaleBloc>(
      () => _i764.LocaleBloc(
        gh<_i404.GetLocaleUsecase>(),
        gh<_i648.SetLocaleUsecase>(),
      ),
    );
    gh.factory<_i362.ThemeBloc>(
      () => _i362.ThemeBloc(
        gh<_i1002.GetAppThemeModeUsecase>(),
        gh<_i109.SetThemeUsecase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i419.AppModule {}
