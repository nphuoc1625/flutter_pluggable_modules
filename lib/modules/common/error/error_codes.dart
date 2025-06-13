/// Centralized error codes for the application.
/// Grouped by module/API for better organization and reusability.
class ErrorCodes {
  const ErrorCodes._();
}

/// Auth Module Error Codes
class AuthErrorCodes {
  const AuthErrorCodes._();

  /// Login related error codes
  static const String emailNotFound = 'EMAIL_NOT_FOUND';
  static const String invalidEmailFormat = 'INVALID_EMAIL_FORMAT';
  static const String invalidPassword = 'INVALID_PASSWORD';

  /// Token related error codes
  static const String tokenNotFound = 'TOKEN_NOT_FOUND';
  static const String tokenExpired = 'TOKEN_EXPIRED';
  static const String refreshFailed = 'REFRESH_FAILED';
}

/// Network Module Error Codes
class NetworkErrorCodes {
  const NetworkErrorCodes._();

  /// No internet connection
  static const String noConnection = 'NO_CONNECTION';

  /// Request timeout
  static const String timeout = 'TIMEOUT';

  /// Server error
  static const String serverError = 'SERVER_ERROR';
}

/// Storage Module Error Codes
class StorageErrorCodes {
  const StorageErrorCodes._();

  /// Failed to read from storage
  static const String readFailed = 'READ_FAILED';

  /// Failed to write to storage
  static const String writeFailed = 'WRITE_FAILED';

  /// Failed to delete from storage
  static const String deleteFailed = 'DELETE_FAILED';
}
