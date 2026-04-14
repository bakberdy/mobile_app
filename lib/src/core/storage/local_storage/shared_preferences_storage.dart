import 'package:injectable/injectable.dart';
import 'package:mobile_app/src/core/storage/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: LocalStorage)
class SharedPreferencesStorage implements LocalStorage {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesStorage({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;
  @override
  Future<bool> containsKey({required String key}) =>
      Future.sync(() => _sharedPreferences.containsKey(key));

  @override
  Future<void> delete({required String key}) =>
      Future.sync(() => _sharedPreferences.remove(key));

  @override
  Future<void> deleteAll() => Future.sync(_sharedPreferences.clear);

  @override
  Future<String?> read({required String key}) =>
      Future.sync(() => _sharedPreferences.getString(key));

  @override
  Future<Map<String, String>> readAll() => Future.sync(() {
    final allKeys = _sharedPreferences.getKeys();
    final Map<String, String> allValues = {};
    for (final key in allKeys) {
      final value = _sharedPreferences.getString(key);
      if (value != null) {
        allValues[key] = value;
      }
    }
    return allValues;
  });

  @override
  Future<void> write({required String key, required String value}) =>
      Future.sync(() => _sharedPreferences.setString(key, value));
}
