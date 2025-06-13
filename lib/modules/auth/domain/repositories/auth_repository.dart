import 'package:flutter_pluggable_modules/modules/auth/domain/errors/auth_error.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/models/token.dart';
import 'package:flutter_pluggable_modules/modules/common/result/result.dart';

/// Repository interface for authentication operations.
///
/// This repository handles all authentication-related operations including:
/// - Login with email and password
/// - Token management (get, refresh, delete)
///
/// All methods return a [Result] type that can contain either:
/// - Success: The expected return type (e.g., [Token] for login)
/// - Error: A specific error type for each method
abstract class AuthRepository {
  /// Logs in a user with email and password.
  ///
  /// Returns a [Result] containing either:
  /// - Success: [Token] with access and refresh tokens
  /// - Error: [LoginError] or its subclasses:
  ///   - [EmailNotFoundError]: When the email doesn't exist
  ///   - [InvalidEmailFormatError]: When email format is invalid
  ///   - [InvalidPasswordError]: When password is incorrect
  Future<Result<Token, LoginError>> loginWithEmail(
    String email,
    String password,
  );

  /// Gets the current authentication token.
  ///
  /// Returns a [Result] containing either:
  /// - Success: [Token] with current access and refresh tokens
  /// - Error: [TokenNotFoundError] when no token exists
  Future<Result<Token, TokenNotFoundError>> getToken();

  /// Refreshes the current authentication token.
  ///
  /// Returns a [Result] containing either:
  /// - Success: [Token] with new access and refresh tokens
  /// - Error: [RefreshTokenError] or its subclasses:
  ///   - [TokenExpiredError]: When refresh token has expired
  ///   - [RefreshFailedError]: When refresh operation fails
  Future<Result<Token, RefreshTokenError>> refreshToken();

  /// Deletes the current authentication token.
  ///
  /// Returns a [Result] containing either:
  /// - Success: `void` when token is successfully deleted
  /// - Error: [TokenNotFoundError] when no token exists to delete
  Future<Result<void, TokenNotFoundError>> deleteToken();
}
