import 'package:flutter_pluggable_modules/modules/auth/domain/errors/auth_error.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/models/token.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/models/user.dart';
import 'package:flutter_pluggable_modules/modules/common/result/result.dart';

class AuthApi {
  final String baseUrl;
  final Map<String, String> headers;

  AuthApi({required this.baseUrl, Map<String, String>? headers})
    : headers = headers ?? {};

  Future<Result<LoginResponse, AuthError>> login(
    String email,
    String password,
  ) async {
    try {
      // TODO: Implement actual API call
      // This is a mock implementation
      await Future.delayed(const Duration(milliseconds: 500));

      if (email == 'error@example.com') {
        return Result.error(EmailNotFoundError());
      }

      return Result.success(
        LoginResponse(
          userId: '1',
          name: 'Test User',
          accessToken: 'mock_access_token',
          refreshToken: 'mock_refresh_token',
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
        ),
      );
    } catch (e) {
      return Result.error(LoginError('Login failed', originalError: e));
    }
  }

  Future<Result<User, AuthError>> getCurrentUser(String accessToken) async {
    try {
      // TODO: Implement actual API call
      // This is a mock implementation
      await Future.delayed(const Duration(milliseconds: 500));

      return Result.success(
        User(
          id: '1',
          email: 'user@example.com',
          name: 'Test User',
          avatarUrl: null,
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
        ),
      );
    } catch (e) {
      return Result.error(UserNotFoundError(originalError: e));
    }
  }

  Future<Result<void, AuthError>> logout(String accessToken) async {
    try {
      // TODO: Implement actual API call
      // This is a mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      return Result.success(null);
    } catch (e) {
      return Result.error(LogoutError('Logout failed', originalError: e));
    }
  }

  Future<Result<User, AuthError>> updateProfile(
    String accessToken,
    String name,
    String? avatarUrl,
  ) async {
    try {
      // TODO: Implement actual API call
      // This is a mock implementation
      await Future.delayed(const Duration(milliseconds: 500));

      return Result.success(
        User(
          id: '1',
          email: 'user@example.com',
          name: name,
          avatarUrl: avatarUrl,
          createdAt: DateTime.now(),
          lastLoginAt: DateTime.now(),
        ),
      );
    } catch (e) {
      return Result.error(
        ProfileUpdateError('Failed to update profile', originalError: e),
      );
    }
  }

  Future<Result<Token, AuthError>> refreshToken(String refreshToken) async {
    try {
      // TODO: Implement actual API call
      // This is a mock implementation
      await Future.delayed(const Duration(milliseconds: 500));

      if (refreshToken == 'expired_token') {
        return Result.error(TokenExpiredError());
      }

      return Result.success(
        Token(
          accessToken: 'new_mock_access_token',
          refreshToken: 'new_mock_refresh_token',
        ),
      );
    } catch (e) {
      return Result.error(RefreshFailedError(originalError: e));
    }
  }
}

class LoginResponse {
  final String userId;
  final String name;
  final String accessToken;
  final String refreshToken;
  final DateTime createdAt;
  final DateTime lastLoginAt;

  LoginResponse({
    required this.userId,
    required this.name,
    required this.accessToken,
    required this.refreshToken,
    required this.createdAt,
    required this.lastLoginAt,
  });
}
