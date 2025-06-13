import 'package:flutter_pluggable_modules/modules/common/error/app_error.dart';

class AuthError extends AppError {
  AuthError(String message, {String? code, dynamic originalError})
    : super(message, code: code, originalError: originalError);
}

class LoginError extends AppError {
  LoginError(super.message, {super.code, super.originalError});
}

class EmailNotFoundError extends LoginError {
  EmailNotFoundError({String? code, dynamic originalError})
    : super(
        'Email not found',
        code: code ?? 'EMAIL_NOT_FOUND',
        originalError: originalError,
      );
}

class InvalidEmailFormatError extends LoginError {
  InvalidEmailFormatError({String? code, dynamic originalError})
    : super(
        'Invalid email format',
        code: code ?? 'INVALID_EMAIL_FORMAT',
        originalError: originalError,
      );
}

class InvalidPasswordError extends LoginError {
  InvalidPasswordError({String? code, dynamic originalError})
    : super(
        'Invalid password',
        code: code ?? 'INVALID_PASSWORD',
        originalError: originalError,
      );
}

class RefreshTokenError extends AppError {
  RefreshTokenError(super.message, {super.code, super.originalError});
}

class TokenExpiredError extends RefreshTokenError {
  TokenExpiredError({String? code, dynamic originalError})
    : super(
        'Token has expired',
        code: code ?? 'TOKEN_EXPIRED',
        originalError: originalError,
      );
}

class RefreshFailedError extends RefreshTokenError {
  RefreshFailedError({String? code, dynamic originalError})
    : super(
        'Failed to refresh token',
        code: code ?? 'REFRESH_FAILED',
        originalError: originalError,
      );
}

class TokenNotFoundError extends AppError {
  TokenNotFoundError({String? code, dynamic originalError})
    : super(
        'Token not found',
        code: code ?? 'TOKEN_NOT_FOUND',
        originalError: originalError,
      );
}
