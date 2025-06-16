import 'package:flutter_pluggable_modules/modules/auth/domain/errors/auth_error.dart';
import 'package:flutter_pluggable_modules/modules/auth/domain/models/user.dart';
import 'package:flutter_pluggable_modules/modules/common/result/result.dart';

/// Repository interface for authentication operations.
///
/// This repository handles core authentication business logic including:
/// - User authentication (login, logout)
/// - User session management
/// - User profile operations
abstract class AuthRepository {
  /// Authenticates a user with email and password.
  ///
  /// Returns a [Result] containing either:
  /// - Success: [User] with authenticated user data
  /// - Error: [LoginError] or its subclasses:
  ///   - [EmailNotFoundError]: When the email doesn't exist
  ///   - [InvalidEmailFormatError]: When email format is invalid
  ///   - [InvalidPasswordError]: When password is incorrect
  Future<Result<User, LoginError>> loginWithEmail(
    String email,
    String password,
  );

  /// Logs out the current user.
  ///
  /// Returns a [Result] containing either:
  /// - Success: `void` when logout is successful
  /// - Error: [LogoutError] when logout fails
  Future<Result<void, LogoutError>> logout();

  /// Gets the current authenticated user.
  ///
  /// Returns a [Result] containing either:
  /// - Success: [User] with current user data
  /// - Error: [UserNotFoundError] when no user is authenticated
  Future<Result<User, UserNotFoundError>> getCurrentUser();

  /// Updates the current user's profile.
  ///
  /// Returns a [Result] containing either:
  /// - Success: [User] with updated user data
  /// - Error: [ProfileUpdateError] when update fails
  Future<Result<User, ProfileUpdateError>> updateProfile(User user);
}
