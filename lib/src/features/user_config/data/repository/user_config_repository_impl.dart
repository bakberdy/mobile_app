import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/error/error.dart';
import 'package:mobile_app/src/core/network/network_info.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';
import 'package:mobile_app/src/features/user_config/configs/local_storage_consts.dart';
import 'package:mobile_app/src/features/user_config/data/datasource/user_config_local_data_source.dart';
import 'package:mobile_app/src/features/user_config/data/datasource/user_config_remote_data_source.dart';
import 'package:mobile_app/src/features/user_config/domain/entity/app_theme_mode.dart';
import 'package:mobile_app/src/features/user_config/domain/repository/user_config_repository.dart';

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
      const storageKey = LocalStorageConsts.themeModeKey;
      final isConnected = await _networkInfo.isConnected;
      final localTheme = await _safeReadLocal(storageKey);
      if (!isConnected) {
        return Right(AppThemeMode.fromString(localTheme));
      }

      unawaited(_syncThemeMode());

      return Right(AppThemeMode.fromString(localTheme));
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.getAppThemeMode'));
    }
  }

  Future<void> _syncThemeMode() async {
    const storageKey = LocalStorageConsts.themeModeKey;
    final localTheme = await _safeReadLocal(storageKey);
    final remoteTheme = await _safeReadRemote(key: storageKey);

    if (localTheme != null && localTheme != remoteTheme) {
      await _remoteDataSource.setUserConfig<String>(
        key: storageKey,
        value: localTheme,
      );
    }
  }

  @override
  FutureEither<String?> getLocale() async {
    try {
      const storageKey = LocalStorageConsts.localeKey;
      final isConnected = await _networkInfo.isConnected;
      final localLocale = await _safeReadLocal(storageKey);

      if (!isConnected) {
        return Right(localLocale);
      }

      unawaited(_syncLocale());

      return Right(localLocale);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.getLocale'));
    }
  }

  Future<void> _syncLocale() async {
    const storageKey = LocalStorageConsts.localeKey;
    final localLocale = await _safeReadLocal(storageKey);
    final remoteLocale = await _safeReadRemote(key: storageKey);

    if (localLocale != null && localLocale != remoteLocale) {
      await _remoteDataSource.setUserConfig<String>(
        key: storageKey,
        value: localLocale,
      );
    }
  }

  @override
  FutureEither<void> setLocale(String locale) async {
    try {
      await _localDataSource.setUserConfig(
        key: LocalStorageConsts.localeKey,
        value: locale,
      );
      unawaited(_syncLocale());
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.setLocale'));
    }
  }

  @override
  FutureEither<void> setTheme(AppThemeMode themeMode) async {
    try {
      await _localDataSource.setUserConfig(
        key: LocalStorageConsts.themeModeKey,
        value: themeMode.name,
      );
      unawaited(_syncThemeMode());

      return const Right(null);
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

  Future<String?> _safeReadRemote({required String key}) async {
    try {
      return await _remoteDataSource.getUserConfig(key: key);
    } on Exception {
      return null;
    }
  }

  @override
  FutureEither<String?> getEnvironment() async =>
      Right(await _safeReadLocal(LocalStorageConsts.environmentKey));

  @override
  FutureEither<void> setEnvironment(String environment) async {
    const storageKey = LocalStorageConsts.environmentKey;
    try {
      await _localDataSource.setUserConfig(key: storageKey, value: environment);

      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toFailure(source: '$runtimeType.setEnvironment'));
    }
  }
}
