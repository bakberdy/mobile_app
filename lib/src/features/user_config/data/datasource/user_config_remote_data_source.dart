import 'package:injectable/injectable.dart';

abstract class UserConfigRemoteDataSource {
  Future<void> setUserConfig<T>({required String key, required T value});
  Future<T?> getUserConfig<T>({required String key});
}

@Singleton(as: UserConfigRemoteDataSource)
class UserConfigRemoteDataSourceImpl implements UserConfigRemoteDataSource {
  @override
  Future<void> setUserConfig<T>({required String key, required T value}) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<T?> getUserConfig<T>({required String key}) async {
    await Future.delayed(const Duration(seconds: 1));

    return null;
  }
}
