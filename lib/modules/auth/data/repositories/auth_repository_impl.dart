import 'package:flutter_pluggable_modules/modules/auth/data/sources/auth_api.dart';
import 'package:flutter_pluggable_modules/modules/auth/data/storages/token_storage.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/errors/auth_error.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/models/token.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/models/user.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_pluggable_modules/modules/common/error/error_codes.dart';
import 'package:flutter_pluggable_modules/modules/common/result/result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final TokenStorage _tokenStorage;
  final AuthApi _authApi;

  AuthRepositoryImpl(this._tokenStorage, this._authApi);

  @override
  Future<Result<User, LoginError>> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      if (!_isValidEmail(email)) {
        return Result.error(InvalidEmailFormatError());
      }

      if (!_isValidPassword(password)) {
        return Result.error(InvalidPasswordError());
      }

      final response = await _authApi.login(email, password);

      if (response.isError) {
        final error = response.error;
        if (error.code == NetworkErrorCodes.noConnection) {
          return Result.error(
            LoginError(
              'Network error occurred',
              code: error.code,
              originalError: error.originalError,
            ),
          );
        }
        return Result.error(
          LoginError(
            error.message,
            code: error.code,
            originalError: error.originalError,
          ),
        );
      }

      final data = response.success;
      final token = Token(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      );

      await _tokenStorage.saveToken(token);

      return Result.success(
        User(
          id: data.userId,
          email: email,
          name: data.name,
          avatarUrl: null,
          createdAt: data.createdAt,
          lastLoginAt: data.lastLoginAt,
        ),
      );
    } catch (e) {
      return Result.error(LoginError('Login failed', originalError: e));
    }
  }

  @override
  Future<Result<User, UserNotFoundError>> getCurrentUser() async {
    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        return Result.error(
          UserNotFoundError(code: AuthErrorCodes.tokenNotFound),
        );
      }

      final response = await _authApi.getCurrentUser(token.accessToken);

      if (response.isError) {
        final error = response.error;
        if (error.code == NetworkErrorCodes.noConnection) {
          return Result.error(
            UserNotFoundError(
              code: error.code,
              originalError: error.originalError,
            ),
          );
        }
        return Result.error(
          UserNotFoundError(
            code: error.code,
            originalError: error.originalError,
          ),
        );
      }

      return Result.success(response.success);
    } catch (e) {
      return Result.error(UserNotFoundError(originalError: e));
    }
  }

  @override
  Future<Result<void, LogoutError>> logout() async {
    try {
      final token = await _tokenStorage.getToken();
      if (token != null) {
        final response = await _authApi.logout(token.accessToken);
        if (response.isError) {
          final error = response.error;
          if (error.code == NetworkErrorCodes.noConnection) {
            return Result.error(
              LogoutError(
                'Network error occurred',
                code: error.code,
                originalError: error.originalError,
              ),
            );
          }
          return Result.error(
            LogoutError(
              error.message,
              code: error.code,
              originalError: error.originalError,
            ),
          );
        }
      }

      await _tokenStorage.deleteToken();
      return Result.success(null);
    } catch (e) {
      return Result.error(LogoutError('Failed to logout', originalError: e));
    }
  }

  @override
  Future<Result<User, ProfileUpdateError>> updateProfile(User user) async {
    try {
      final token = await _tokenStorage.getToken();
      if (token == null) {
        return Result.error(
          ProfileUpdateError(
            'Not authenticated',
            code: AuthErrorCodes.tokenNotFound,
          ),
        );
      }

      if (user.name?.isEmpty ?? true) {
        return Result.error(
          ProfileUpdateError(
            'Name cannot be empty',
            code: AuthErrorCodes.invalidEmailFormat,
          ),
        );
      }

      final response = await _authApi.updateProfile(
        token.accessToken,
        user.name ?? '',
        user.avatarUrl,
      );

      if (response.isError) {
        final error = response.error;
        if (error.code == NetworkErrorCodes.noConnection) {
          return Result.error(
            ProfileUpdateError(
              'Network error occurred',
              code: error.code,
              originalError: error.originalError,
            ),
          );
        }
        return Result.error(
          ProfileUpdateError(
            error.message,
            code: error.code,
            originalError: error.originalError,
          ),
        );
      }

      return Result.success(response.success);
    } catch (e) {
      return Result.error(
        ProfileUpdateError('Failed to update profile', originalError: e),
      );
    }
  }

  // Token management methods (implementation details)
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

  Future<Result<Token, RefreshFailedError>> refreshToken() async {
    try {
      final currentToken = await _tokenStorage.getToken();
      if (currentToken == null) {
        return Result.error(
          RefreshFailedError(code: AuthErrorCodes.tokenNotFound),
        );
      }

      final response = await _authApi.refreshToken(currentToken.refreshToken);

      if (response.isError) {
        final error = response.error;
        if (error.code == NetworkErrorCodes.noConnection) {
          return Result.error(
            RefreshFailedError(
              code: error.code,
              originalError: error.originalError,
            ),
          );
        }
        return Result.error(
          RefreshFailedError(
            code: error.code,
            originalError: error.originalError,
          ),
        );
      }

      final newToken = response.success;
      await _tokenStorage.saveToken(newToken);
      return Result.success(newToken);
    } catch (e) {
      return Result.error(RefreshFailedError(originalError: e));
    }
  }

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

  bool _isValidEmail(String email) {
    // TODO: Implement proper email validation
    return email.contains('@');
  }

  bool _isValidPassword(String password) {
    // TODO: Implement proper password validation
    return password.length >= 6;
  }
}
