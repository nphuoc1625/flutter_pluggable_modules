import 'package:flutter_pluggable_modules/modules/common/result/result.dart';

import '../../domain/models/token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../storages/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._tokenStorage);

  @override
  Future<Result<Token, AuthError>> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      // Simulated backend login
      await Future.delayed(Duration(seconds: 1));
      final token = Token(
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
      );
      await _tokenStorage.saveToken(token);
      return Result.success(token);
    } catch (e) {
      return Result.error(AuthError('Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void, AuthError>> logout() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
      await _tokenStorage.deleteToken();
      return Result.success(null);
    } catch (e) {
      return Result.error(AuthError('Logout failed: ${e.toString()}'));
    }
  }

  @override
  Future<Result<bool, AuthError>> isLoggedIn() async {
    try {
      final token = await _tokenStorage.getToken();
      return Result.success(token != null);
    } catch (e) {
      return Result.error(
        AuthError('Failed to check login status: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<Token, AuthError>> getToken() async {
    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        return Result.error(AuthError('No token found'));
      }
      return Result.success(token);
    } catch (e) {
      return Result.error(AuthError('Failed to get token: ${e.toString()}'));
    }
  }

  @override
  Future<Result<Token, AuthError>> refreshToken() async {
    try {
      // Simulate token refresh
      await Future.delayed(Duration(milliseconds: 500));
      final token = Token(
        accessToken: 'refreshed_access_token',
        refreshToken: 'refreshed_refresh_token',
      );
      await _tokenStorage.saveToken(token);
      return Result.success(token);
    } catch (e) {
      return Result.error(AuthError('Token refresh failed: ${e.toString()}'));
    }
  }
}
