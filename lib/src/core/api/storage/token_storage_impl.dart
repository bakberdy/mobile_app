import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'token_storage.dart';

class TokenStorageImpl implements TokenStorage {
  final FlutterSecureStorage _storage;

  static const _accessKey = 'auth_token';
  static const _refreshKey = 'refresh_token';
  static const _expiryKey = 'token_expiry';

  const TokenStorageImpl(this._storage);

  @override
  Future<void> saveAccessToken(String token) =>
      _storage.write(key: _accessKey, value: token);

  @override
  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _refreshKey, value: token);

  @override
  Future<String?> getAccessToken() => _storage.read(key: _accessKey);

  @override
  Future<String?> getRefreshToken() => _storage.read(key: _refreshKey);

  @override
  Future<bool> containsRefreshToken() =>
      _storage.containsKey(key: _refreshKey);

  @override
  Future<void> clearTokens() => Future.wait([
        _storage.delete(key: _accessKey),
        _storage.delete(key: _refreshKey),
        _storage.delete(key: _expiryKey),
      ]);
}
