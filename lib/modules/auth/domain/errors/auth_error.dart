import 'package:flutter_pluggable_modules/modules/common/error/app_error.dart';
import 'package:flutter_pluggable_modules/modules/common/error/error_codes.dart';

class AuthError extends AppError {
  AuthError(super.message, {super.code, super.originalError});
}

class LoginError extends AppError {
  LoginError(super.message, {super.code, super.originalError});
}

class EmailNotFoundError extends LoginError {
  EmailNotFoundError({String? code, dynamic originalError})
    : super(
        'Email not found',
        code: code ?? AuthErrorCodes.emailNotFound,
        originalError: originalError,
      );
}

class InvalidEmailFormatError extends LoginError {
  InvalidEmailFormatError({String? code, dynamic originalError})
    : super(
        'Invalid email format',
        code: code ?? AuthErrorCodes.invalidEmailFormat,
        originalError: originalError,
      );
}

class InvalidPasswordError extends LoginError {
  InvalidPasswordError({String? code, dynamic originalError})
    : super(
        'Invalid password',
        code: code ?? AuthErrorCodes.invalidPassword,
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
        code: code ?? AuthErrorCodes.tokenExpired,
        originalError: originalError,
      );
}

class RefreshFailedError extends RefreshTokenError {
  RefreshFailedError({String? code, dynamic originalError})
    : super(
        'Failed to refresh token',
        code: code ?? AuthErrorCodes.refreshFailed,
        originalError: originalError,
      );
}

class TokenNotFoundError extends AppError {
  TokenNotFoundError({String? code, dynamic originalError})
    : super(
        'Token not found',
        code: code ?? AuthErrorCodes.tokenNotFound,
        originalError: originalError,
      );
}
