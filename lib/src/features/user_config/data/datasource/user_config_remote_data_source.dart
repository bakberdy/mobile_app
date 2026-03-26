import 'package:injectable/injectable.dart';

abstract class UserConfigRemoteDataSource {
  Future<void> setUserConfig<T>({required String key, required T value});
  Future<T?> getUserConfig<T>({required String key});
}

@Singleton(as: UserConfigRemoteDataSource)
class UserConfigRemoteDataSourceImpl implements UserConfigRemoteDataSource {
  @override
  Future<void> setUserConfig<T>({
    required String key,
    required T value,
  }) async {
    _ensureSupportedValue(value);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would make an API call to save the config
  }

  @override
  Future<T?> getUserConfig<T>({required String key}) async {
    _ensureSupportedType<T>();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would make an API call to fetch the config
    return null; // Return null to indicate no config found
  }

  void _ensureSupportedValue(Object? value) {
    if (value is String || value is int || value is double || value is bool) {
      return;
    }

    throw Exception(
      'Unsupported value type ${value.runtimeType}. '
      'Only String, int, double, bool are allowed.',
    );
  }

  void _ensureSupportedType<T>() {
    if (T == String || T == int || T == double || T == bool) {
      return;
    }

    throw Exception(
      'Unsupported generic type $T. '
      'Only String, int, double, bool are allowed.',
    );
  }
}
