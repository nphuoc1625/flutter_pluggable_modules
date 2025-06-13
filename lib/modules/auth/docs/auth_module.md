# Auth Module Documentation

## Overview
The Auth Module is a pluggable module that handles authentication-related functionality in the application. It follows a clean architecture pattern with clear separation of concerns between data and domain layers.

## Error Codes
All error codes are centralized here for consistency across the application:

### Login Errors
- `EMAIL_NOT_FOUND`: Email address not registered
- `INVALID_PASSWORD`: Password is incorrect
- `INVALID_EMAIL_FORMAT`: Email format is invalid

### Token Errors
- `TOKEN_NOT_FOUND`: No token exists in storage
- `TOKEN_EXPIRED`: Token has expired
- `REFRESH_FAILED`: Failed to refresh token

## Dependency Tree
```
AuthModule
├── Storage (from common module)
│   └── SecureStorageImpl
├── Result (from common module)
│   └── Generic Result<T, E>
├── AppError (from common module)
│   ├── UnknownError
│   ├── NetworkError
│   ├── StorageError
│   ├── LoginError
│   │   ├── EmailNotFoundError
│   │   ├── InvalidEmailFormatError
│   │   └── InvalidPasswordError
│   ├── RefreshTokenError
│   │   ├── TokenExpiredError
│   │   └── RefreshFailedError
│   └── TokenNotFoundError
├── TokenStorage
│   ├── Storage (dependency)
│   └── Token (from domain)
└── AuthRepository
    ├── TokenStorage (dependency)
    └── Token (from domain)
```

### Component Dependencies
1. **AuthModule**
   - Depends on: `Storage`, `TokenStorage`, `AuthRepository`
   - Used by: Application root

2. **TokenStorage**
   - Depends on: `Storage`, `Token`
   - Used by: `AuthRepositoryImpl`

3. **AuthRepository**
   - Depends on: `Token`, `Result`, `AppError`
   - Implemented by: `AuthRepositoryImpl`

4. **Token**
   - No dependencies
   - Used by: `TokenStorage`, `AuthRepository`

5. **Result**
   - No dependencies
   - Used by: `AuthRepository` for error handling

6. **AppError**
   - No dependencies
   - Base class for all application errors
   - Extended by specific error types:
     - Common errors: `UnknownError`, `NetworkError`, `StorageError`
     - Auth errors: `LoginError`, `RefreshTokenError`, `TokenNotFoundError`

## Models and Classes

### Common Models
- **[`Result<T, E>`](../../common/result/result.dart)**
  - Generic class for handling success and error cases
  - Type parameters: `T` for success value, `E` for error value
  - Provides `fold` method for handling both cases

- **[`AppError`](../../common/error/app_error.dart)**
  - Base abstract class for all application errors
  - Contains message, code, and original error
  - Extended by specific error types

### Domain Models
- **[`Token`](../domain/models/token.dart)**
  - Data class for managing authentication tokens
  - Contains `accessToken` and `refreshToken` fields
  - Implements JSON serialization/deserialization

- **[`Auth Errors`](../domain/errors/auth_error.dart)**
  - Extend `AppError` directly
  - Provide specific error types:
    - `LoginError`: Email not found, invalid format, invalid password
    - `RefreshTokenError`: Token expired, refresh failed
    - `TokenNotFoundError`: Token not found in storage

### Storage Classes
- **[`TokenStorage`](../data/storages/token_storage.dart)**
  - Handles secure storage of authentication tokens
  - Manages both access and refresh tokens
  - Implements caching mechanism

### Repository Classes
- **[`AuthRepository`](../domain/repositories/auth_repository.dart)**
  - Interface defining authentication operations
  - Uses `Result` class for error handling
  - Abstract class for auth repository implementations
- **[`AuthRepositoryImpl`](../data/repositories/auth_repository_impl.dart)**
  - Concrete implementation of AuthRepository
  - Handles actual authentication logic
  - Implements error handling using `Result`
  - Maps both server response errors and exceptions to domain-specific errors

### Module Classes
- **[`AuthModule`](auth_module.dart)**
  - Main entry point for the auth module
  - Handles dependency injection using GetX

## Module Structure
```
auth/
├── auth_module.dart
├── data/
│   ├── repositories/
│   │   └── auth_repository_impl.dart
│   └── storages/
│       └── token_storage.dart
├── domain/
│   ├── errors/
│   │   └── auth_error.dart
│   ├── models/
│   │   └── token.dart
│   └── repositories/
│       └── auth_repository.dart
└── docs/
    └── auth_module.md
```

## Dependencies
- **get**: Used for dependency injection and state management
- **storage**: Common module dependency for secure storage implementation
- **result**: Common module dependency for error handling
- **error**: Common module dependency for error hierarchy

## Components

### AuthModule
The main entry point for the auth module that handles dependency injection.

#### Dependencies Injected:
1. `Storage` (SecureStorageImpl)
2. `TokenStorage`
3. `AuthRepository` (AuthRepositoryImpl)

## Usage
To use the auth module in your application:

1. Import the auth module:
```dart
import 'package:your_app/modules/auth/auth_module.dart';
```

2. Initialize the module:
```dart
AuthModule.inject();
```

3. Access the repository:
```dart
final authRepository = Get.find<AuthRepository>();
```

4. Working with tokens:
```dart
// Login
final loginResult = await authRepository.loginWithEmail('email', 'password');
loginResult.fold(
  (token) => print('Logged in with token: ${token.accessToken}'),
  (error) {
    if (error is EmailNotFoundError) {
      print('Email not found');
    } else if (error is InvalidEmailFormatError) {
      print('Invalid email format');
    } else if (error is InvalidPasswordError) {
      print('Invalid password');
    } else {
      print('Login failed: ${error.message}');
    }
  }
);

// Get token
final tokenResult = await authRepository.getToken();
tokenResult.fold(
  (token) => print('Token: ${token.accessToken}'),
  (error) {
    if (error is TokenNotFoundError) {
      print('Token not found');
    } else if (error is TokenExpiredError) {
      print('Token expired');
    } else {
      print('Failed to get token: ${error.message}');
    }
  }
);
```

## Error Handling
The module implements a comprehensive error handling system:

1. **Server Response Errors**
   - Parsed from backend responses
   - Mapped to specific domain errors
   - Includes error codes and messages

2. **Exception Handling**
   - Catches unexpected errors
   - Maps to appropriate domain errors
   - Preserves original errors for debugging

3. **Error Hierarchy**
   - Base `AppError` class for all errors
   - Method-specific error types (e.g., `LoginError`, `RefreshTokenError`)
   - Specific error cases (e.g., `EmailNotFoundError`, `TokenExpiredError`)

## Notes
- The module uses GetX for dependency injection
- Token storage is implemented using secure storage
- The module is designed to be easily pluggable into any Flutter application
- Both access token and refresh token are stored securely using JSON serialization
- Error handling is implemented using the `Result` class from common module
- Errors are organized in a hierarchy with specific types for different scenarios
- Repository implementations map both server response errors and exceptions to domain-specific errors