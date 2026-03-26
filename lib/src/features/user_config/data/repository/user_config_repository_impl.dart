import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_app/src/core/error/error.dart';
import 'package:travel_app/src/core/network/network_info.dart';
import 'package:travel_app/src/core/utils/typedef.dart';
import 'package:travel_app/src/features/user_config/data/datasource/user_config_local_data_source.dart';
import 'package:travel_app/src/features/user_config/data/datasource/user_config_remote_data_source.dart';
import 'package:travel_app/src/features/user_config/domain/entity/app_theme_mode.dart';
import 'package:travel_app/src/features/user_config/domain/repository/user_config_repository.dart';
import 'package:travel_app/src/features/user_config/user_config_consts.dart';

@Singleton(as: UserConfigRepository)
class UserConfigRepositoryImpl implements UserConfigRepository {
  final UserConfigLocalDataSource _localDataSource;
  final UserConfigRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  UserConfigRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._networkInfo,
  );
  

  @override
  FutureEither<AppThemeMode?> getAppThemeMode() async {
    try {
      final storageKey = UserConfigConsts.themeModeKey;
      final isConnected = await _networkInfo.isConnected;
      final localTheme = await _safeReadLocal(storageKey);
      final remoteTheme = await _safeReadRemote(
        key: storageKey,
        isConnected: isConnected,
      );

      final resolvedTheme = _resolveTheme(
        localRaw: localTheme,
        remoteRaw: remoteTheme,
      );

      if (resolvedTheme != null) {
        await _bestEffortSync(
          key: storageKey,
          resolvedValue: resolvedTheme.name,
          localValue: localTheme,
          remoteValue: remoteTheme,
          isConnected: isConnected,
        );
      }

      return Right(resolvedTheme);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.getAppThemeMode'));
    }
  }

  @override
  FutureEither<String?> getLocale() async {
    try {
      final storageKey = UserConfigConsts.localeKey;
      final isConnected = await _networkInfo.isConnected;
      final localLocale = await _safeReadLocal(storageKey);
      final remoteLocale = await _safeReadRemote(
        key: storageKey,
        isConnected: isConnected,
      );

      final resolvedLocale = _resolveLocale(
        localRaw: localLocale,
        remoteRaw: remoteLocale,  
      );

      if (resolvedLocale != null) {
        await _bestEffortSync(
          key: storageKey,
          resolvedValue: resolvedLocale,
          localValue: localLocale,
          remoteValue: remoteLocale,
          isConnected: isConnected,
        );
      }

      return Right(resolvedLocale);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.getLocale'));
    }
  }

  @override
  FutureEither<void> setLocale(String locale) async {
    try {
      await _setOfflineFirst(
        key: UserConfigConsts.localeKey,
        value: locale,
      );

      return Right(null);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.setLocale'));
    }
  }

  @override
  FutureEither<void> setTheme(AppThemeMode themeMode) async {
    try {
      await _setOfflineFirst(
        key: UserConfigConsts.themeModeKey,
        value: themeMode.name,
      );

      return Right(null);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.setTheme'));
    }
  }

  Future<String?> _safeReadLocal(String key) async {
    try {
      return await _localDataSource.getUserConfig(key: key);
    } on Exception {
      return null;
    }
  }

  Future<String?> _safeReadRemote({
    required String key,
    required bool isConnected,
  }) async {
    if (!isConnected) {
      return null;
    }

    try {
      return await _remoteDataSource.getUserConfig(key: key);
    } on Exception {
      return null;
    }
  }

  Future<void> _bestEffortSync({
    required String key,
    required String resolvedValue,
    required String? localValue,
    required String? remoteValue,
    required bool isConnected,
  }) async {
    if (localValue != resolvedValue) {
      try {
        await _localDataSource.setUserConfig(key: key, value: resolvedValue);
      } on Exception {
        // Best-effort sync.
      }
    }

    if (isConnected && remoteValue != resolvedValue) {
      try {
        await _remoteDataSource.setUserConfig(
          key: key,
          value: resolvedValue,
        );
      } on Exception {
        // Best-effort sync.
      }
    }
  }

  Future<void> _setOfflineFirst({
    required String key,
    required String value,
  }) async {
    await _localDataSource.setUserConfig(key: key, value: value);

    if (!await _networkInfo.isConnected) {
      return;
    }

    try {
      await _remoteDataSource.setUserConfig(key: key, value: value);
    } on Exception {
      // Best-effort sync.
    }
  }

  String? _resolveLocale({
    required String? localRaw,
    required String? remoteRaw,
  }) {
    final local = localRaw?.trim();
    if (local != null && local.isNotEmpty) {
      return local;
    }

    final remote = remoteRaw?.trim();
    if (remote != null && remote.isNotEmpty) {
      return remote;
    }

    return null; // No saved locale — first launch; caller uses device locale.
  }

  AppThemeMode? _resolveTheme({
    required String? localRaw,
    required String? remoteRaw,
  }) {
    final local = AppThemeMode.fromString(localRaw);
    if (local != null) {
      return local;
    }

    final remote = AppThemeMode.fromString(remoteRaw);
    if (remote != null) {
      return remote;
    }

    return null;
  }
}
