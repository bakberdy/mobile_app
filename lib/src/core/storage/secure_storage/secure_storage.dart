/// Abstract interface for secure storage
/// This allows easy swapping of storage implementations
abstract class SecureStorage {
  /// Write a value to secure storage
  Future<void> write({required String key, required String value});

  /// Read a value from secure storage
  Future<String?> read({required String key});

  /// Delete a value from secure storage
  Future<void> delete({required String key});

  /// Delete all values from secure storage
  Future<void> deleteAll();

  /// Check if a key exists in secure storage
  Future<bool> containsKey({required String key});

  /// Read all keys from secure storage
  Future<Map<String, String>> readAll();
}
