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
import 'package:mobile_app/app_config.dart' as _i919;
import 'package:mobile_app/src/config/di/app_module.dart' as _i982;
import 'package:mobile_app/src/config/router/app_router.dart' as _i3;
import 'package:mobile_app/src/config/router/auth_guard.dart' as _i480;
import 'package:mobile_app/src/core/api/api.dart' as _i464;
import 'package:mobile_app/src/core/monitoring/observers/analytics_page_observer.dart'
    as _i35;
import 'package:mobile_app/src/core/network/network_info.dart' as _i946;
import 'package:mobile_app/src/core/storage/local_storage/local_storage.dart'
    as _i581;
import 'package:mobile_app/src/core/storage/local_storage/shared_preferences_storage.dart'
    as _i836;
import 'package:mobile_app/src/core/storage/secure_storage/flutter_secure_storage_impl.dart'
    as _i71;
import 'package:mobile_app/src/core/storage/secure_storage/secure_storage.dart'
    as _i1022;
import 'package:mobile_app/src/features/example/data/datasource/example_local_data_source.dart'
    as _i402;
import 'package:mobile_app/src/features/example/data/repository/example_repository_impl.dart'
    as _i24;
import 'package:mobile_app/src/features/example/domain/repository/example_repository.dart'
    as _i220;
import 'package:mobile_app/src/features/example/domain/usecases/example_create_todo_use_case.dart'
    as _i567;
import 'package:mobile_app/src/features/example/domain/usecases/example_get_todos_use_case.dart'
    as _i760;
import 'package:mobile_app/src/features/example/domain/usecases/example_remove_todo_use_case.dart'
    as _i536;
import 'package:mobile_app/src/features/example/domain/usecases/example_update_todo_use_case.dart'
    as _i1002;
import 'package:mobile_app/src/features/example/presentation/bloc/todo_editor_bloc/example_todo_editor_bloc.dart'
    as _i328;
import 'package:mobile_app/src/features/example/presentation/bloc/todos_bloc/example_todos_bloc.dart'
    as _i946;
import 'package:mobile_app/src/features/user_config/data/datasource/user_config_local_data_source.dart'
    as _i357;
import 'package:mobile_app/src/features/user_config/data/datasource/user_config_remote_data_source.dart'
    as _i927;
import 'package:mobile_app/src/features/user_config/data/repository/user_config_repository_impl.dart'
    as _i613;
import 'package:mobile_app/src/features/user_config/domain/repository/user_config_repository.dart'
    as _i656;
import 'package:mobile_app/src/features/user_config/domain/usecases/get_app_theme_mode_usecase.dart'
    as _i10;
import 'package:mobile_app/src/features/user_config/domain/usecases/get_locale_usecase.dart'
    as _i366;
import 'package:mobile_app/src/features/user_config/domain/usecases/set_locale_usecase.dart'
    as _i111;
import 'package:mobile_app/src/features/user_config/domain/usecases/set_theme_usecase.dart'
    as _i605;
import 'package:mobile_app/src/features/user_config/presentation/bloc/locale_bloc/locale_bloc.dart'
    as _i622;
import 'package:mobile_app/src/features/user_config/presentation/bloc/theme_bloc/theme_bloc.dart'
    as _i198;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i919.AppConfig>(() => appModule.appConfig);
    gh.singleton<_i895.Connectivity>(() => appModule.connectivity);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i558.FlutterSecureStorage>(() => appModule.secureStorage);
    gh.lazySingleton<_i35.AnalyticsPageObserver>(
      () => _i35.AnalyticsPageObserver(),
    );
    gh.lazySingleton<_i1022.SecureStorage>(
      () => _i71.FlutterSecureStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i946.NetworkInfo>(
      () => _i946.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.singleton<_i927.UserConfigRemoteDataSource>(
      () => _i927.UserConfigRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i581.LocalStorage>(
      () => _i836.SharedPreferencesStorage(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.singleton<_i464.TokenStorage>(
      () => appModule.tokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i480.AuthGuard>(
      () => appModule.authGuard(gh<_i464.TokenStorage>()),
    );
    gh.lazySingleton<_i402.ExampleLocalDataSource>(
      () => _i402.ExampleLocalDataSourceImpl(gh<_i581.LocalStorage>()),
    );
    gh.singleton<_i357.UserConfigLocalDataSource>(
      () => _i357.UserConfigLocalDataSourceImpl(
        localStorage: gh<_i581.LocalStorage>(),
      ),
    );
    gh.lazySingleton<_i464.ApiClient>(
      () =>
          appModule.apiClient(gh<_i464.TokenStorage>(), gh<_i919.AppConfig>()),
    );
    gh.singleton<_i656.UserConfigRepository>(
      () => _i613.UserConfigRepositoryImpl(
        gh<_i357.UserConfigLocalDataSource>(),
        gh<_i927.UserConfigRemoteDataSource>(),
        gh<_i946.NetworkInfo>(),
      ),
    );
    gh.singleton<_i3.AppRouter>(
      () => appModule.appRouter(gh<_i480.AuthGuard>()),
    );
    gh.lazySingleton<_i220.ExampleRepository>(
      () => _i24.ExampleRepositoryImpl(gh<_i402.ExampleLocalDataSource>()),
    );
    gh.lazySingleton<_i10.GetAppThemeModeUsecase>(
      () => _i10.GetAppThemeModeUsecase(gh<_i656.UserConfigRepository>()),
    );
    gh.lazySingleton<_i366.GetLocaleUsecase>(
      () => _i366.GetLocaleUsecase(gh<_i656.UserConfigRepository>()),
    );
    gh.lazySingleton<_i111.SetLocaleUsecase>(
      () => _i111.SetLocaleUsecase(gh<_i656.UserConfigRepository>()),
    );
    gh.lazySingleton<_i605.SetThemeUsecase>(
      () => _i605.SetThemeUsecase(gh<_i656.UserConfigRepository>()),
    );
    gh.lazySingleton<_i567.CreateTodoUseCase>(
      () => _i567.CreateTodoUseCase(gh<_i220.ExampleRepository>()),
    );
    gh.lazySingleton<_i760.GetTodosUseCase>(
      () => _i760.GetTodosUseCase(gh<_i220.ExampleRepository>()),
    );
    gh.lazySingleton<_i536.RemoveTodoUseCase>(
      () => _i536.RemoveTodoUseCase(gh<_i220.ExampleRepository>()),
    );
    gh.lazySingleton<_i1002.UpdateTodoUseCase>(
      () => _i1002.UpdateTodoUseCase(gh<_i220.ExampleRepository>()),
    );
    gh.factory<_i946.ExampleTodosBloc>(
      () => _i946.ExampleTodosBloc(
        gh<_i760.GetTodosUseCase>(),
        gh<_i567.CreateTodoUseCase>(),
        gh<_i1002.UpdateTodoUseCase>(),
        gh<_i536.RemoveTodoUseCase>(),
      ),
    );
    gh.factory<_i622.LocaleBloc>(
      () => _i622.LocaleBloc(
        gh<_i366.GetLocaleUsecase>(),
        gh<_i111.SetLocaleUsecase>(),
      ),
    );
    gh.factory<_i198.ThemeBloc>(
      () => _i198.ThemeBloc(
        gh<_i10.GetAppThemeModeUsecase>(),
        gh<_i605.SetThemeUsecase>(),
      ),
    );
    gh.factory<_i328.ExampleTodoEditorBloc>(
      () => _i328.ExampleTodoEditorBloc(
        gh<_i567.CreateTodoUseCase>(),
        gh<_i1002.UpdateTodoUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i982.AppModule {}
