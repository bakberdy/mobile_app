import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/storage/local_storage/local_storage.dart';

abstract class UserConfigLocalDataSource {
  Future<void> setUserConfig({required String key, required String value});
  Future<String?> getUserConfig({required String key});
}

@Singleton(as: UserConfigLocalDataSource)
class UserConfigLocalDataSourceImpl implements UserConfigLocalDataSource {
  final LocalStorage localStorage;

  UserConfigLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> setUserConfig({required String key, required String value}) =>
      localStorage.write(key: key, value: value);

  @override
  Future<String?> getUserConfig({required String key}) =>
      localStorage.read(key: key);
}
