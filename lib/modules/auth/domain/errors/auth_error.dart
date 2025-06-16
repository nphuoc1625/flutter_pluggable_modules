import 'package:flutter_pluggable_modules/modules/common/error/error_codes.dart';

/// Base class for all authentication-related errors.
abstract class AuthError {
  final String message;
  final String? code;
  final dynamic originalError;

  AuthError(this.message, {this.code, this.originalError});
}

/// Error thrown when login fails.
class LoginError extends AuthError {
  LoginError(String message, {String? code, dynamic originalError})
    : super(message, code: code, originalError: originalError);
}

/// Error thrown when the email is not found.
class EmailNotFoundError extends LoginError {
  EmailNotFoundError({String? code, dynamic originalError})
    : super('Email not found', code: code, originalError: originalError);
}

/// Error thrown when the email format is invalid.
class InvalidEmailFormatError extends LoginError {
  InvalidEmailFormatError({String? code, dynamic originalError})
    : super('Invalid email format', code: code, originalError: originalError);
}

/// Error thrown when the password is incorrect.
class InvalidPasswordError extends LoginError {
  InvalidPasswordError({String? code, dynamic originalError})
    : super('Invalid password', code: code, originalError: originalError);
}

/// Error thrown when logout fails.
class LogoutError extends AuthError {
  LogoutError(String message, {String? code, dynamic originalError})
    : super(message, code: code, originalError: originalError);
}

/// Error thrown when user is not found.
class UserNotFoundError extends AuthError {
  UserNotFoundError({String? code, dynamic originalError})
    : super('User not found', code: code, originalError: originalError);
}

/// Error thrown when profile update fails.
class ProfileUpdateError extends AuthError {
  ProfileUpdateError(String message, {String? code, dynamic originalError})
    : super(message, code: code, originalError: originalError);
}

/// Error thrown when token refresh fails.
class RefreshTokenError extends AuthError {
  RefreshTokenError(String message, {String? code, dynamic originalError})
    : super(message, code: code, originalError: originalError);
}

/// Error thrown when token has expired.
class TokenExpiredError extends RefreshTokenError {
  TokenExpiredError({String? code, dynamic originalError})
    : super(
        'Token has expired',
        code: code ?? AuthErrorCodes.tokenExpired,
        originalError: originalError,
      );
}

/// Error thrown when token refresh fails.
class RefreshFailedError extends RefreshTokenError {
  RefreshFailedError({String? code, dynamic originalError})
    : super(
        'Failed to refresh token',
        code: code ?? AuthErrorCodes.refreshFailed,
        originalError: originalError,
      );
}

/// Error thrown when token is not found.
class TokenNotFoundError extends AuthError {
  TokenNotFoundError({String? code, dynamic originalError})
    : super(
        'Token not found',
        code: code ?? AuthErrorCodes.tokenNotFound,
        originalError: originalError,
      );
}
