import 'package:flutter_pluggable_modules/modules/auth/data/storages/token_storage.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/errors/auth_error.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/models/token.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_pluggable_modules/modules/common/error/error_codes.dart';
import 'package:flutter_pluggable_modules/modules/common/result/result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._tokenStorage);

  @override
  Future<Result<Token, LoginError>> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      // TODO: Call actual auth service
      final response = await _mockAuthService(email, password);

      if (response['error'] != null) {
        final error = response['error'];
        switch (error['code']) {
          case AuthErrorCodes.emailNotFound:
            return Result.error(EmailNotFoundError());
          case AuthErrorCodes.invalidPassword:
            return Result.error(InvalidPasswordError());
          case AuthErrorCodes.invalidEmailFormat:
            return Result.error(InvalidEmailFormatError());
          default:
            return Result.error(LoginError(error['message'] ?? 'Login failed'));
        }
      }

      final token = Token(
        accessToken: response['accessToken'],
        refreshToken: response['refreshToken'],
      );

      await _tokenStorage.saveToken(token);
      return Result.success(token);
    } catch (e) {
      if (e is LoginError) {
        return Result.error(e);
      }
      return Result.error(LoginError('Login failed', originalError: e));
    }
  }

  @override
  Future<Result<Token, TokenNotFoundError>> getToken() async {
    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        return Result.error(TokenNotFoundError());
      }
      return Result.success(token);
    } catch (e) {
      if (e is TokenNotFoundError) {
        return Result.error(e);
      }
      return Result.error(TokenNotFoundError(originalError: e));
    }
  }

  @override
  Future<Result<Token, RefreshTokenError>> refreshToken() async {
    try {
      final currentToken = await _tokenStorage.getToken();
      if (currentToken == null) {
        return Result.error(TokenExpiredError());
      }

      // TODO: Call actual auth service to refresh token
      final response = await _mockRefreshToken(currentToken.refreshToken);

      if (response['error'] != null) {
        final error = response['error'];
        switch (error['code']) {
          case AuthErrorCodes.tokenExpired:
            return Result.error(TokenExpiredError());
          case AuthErrorCodes.refreshFailed:
            return Result.error(RefreshFailedError());
          default:
            return Result.error(RefreshFailedError());
        }
      }

      final newToken = Token(
        accessToken: response['accessToken'],
        refreshToken: response['refreshToken'],
      );

      await _tokenStorage.saveToken(newToken);
      return Result.success(newToken);
    } catch (e) {
      if (e is RefreshTokenError) {
        return Result.error(e);
      }
      return Result.error(RefreshFailedError(originalError: e));
    }
  }

  @override
  Future<Result<void, TokenNotFoundError>> deleteToken() async {
    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        return Result.error(TokenNotFoundError());
      }
      await _tokenStorage.deleteToken();
      return Result.success(null);
    } catch (e) {
      if (e is TokenNotFoundError) {
        return Result.error(e);
      }
      return Result.error(TokenNotFoundError(originalError: e));
    }
  }

  // Mock service calls for demonstration
  Future<Map<String, dynamic>> _mockAuthService(
    String email,
    String password,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Simulate error response
    if (email == 'error@example.com') {
      return {
        'error': {
          'code': AuthErrorCodes.emailNotFound,
          'message': 'Email not found',
        },
      };
    }

    // Simulate success response
    return {
      'accessToken': 'mock_access_token',
      'refreshToken': 'mock_refresh_token',
    };
  }

  Future<Map<String, dynamic>> _mockRefreshToken(String refreshToken) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Simulate error response
    if (refreshToken == 'expired_token') {
      return {
        'error': {
          'code': AuthErrorCodes.tokenExpired,
          'message': 'Token has expired',
        },
      };
    }

    // Simulate success response
    return {
      'accessToken': 'new_mock_access_token',
      'refreshToken': 'new_mock_refresh_token',
    };
  }

  bool _isValidEmail(String email) {
    // TODO: Implement proper email validation
    return email.contains('@');
  }

  bool _isValidPassword(String password) {
    // TODO: Implement proper password validation
    return password.length >= 6;
  }
}
