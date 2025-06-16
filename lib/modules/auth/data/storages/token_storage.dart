import 'dart:convert';

import 'package:flutter_pluggable_modules/modules/auth/domain/models/token.dart';
import 'package:flutter_pluggable_modules/modules/common/storage/storage.dart';

class TokenStorage {
  final Storage _storage;
  static const _key = 'auth_token';
  Token? _cachedToken;

  TokenStorage(this._storage);

  Future<void> init() async {
    final tokenJson = await _storage.read(_key);
    if (tokenJson != null) {
      _cachedToken = Token.fromJson(jsonDecode(tokenJson));
    }
  }

  Future<void> saveToken(Token token) async {
    _cachedToken = token;
    await _storage.write(_key, jsonEncode(token.toJson()));
  }

  Future<Token?> getToken() async {
    if (_cachedToken != null) return _cachedToken;

    final tokenJson = await _storage.read(_key);
    if (tokenJson == null) return null;

    return _cachedToken = Token.fromJson(jsonDecode(tokenJson));
  }

  Future<void> deleteToken() async {
    _cachedToken = null;
    await _storage.delete(_key);
  }
}
