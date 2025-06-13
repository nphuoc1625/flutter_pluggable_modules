# Auth Module Documentation

## Overview
The Auth Module is a pluggable module that handles authentication-related functionality in the application. It follows a clean architecture pattern with clear separation of concerns between data and domain layers.

## Dependency Tree
```
AuthModule
├── Storage (from common module)
│   └── SecureStorageImpl
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
   - Depends on: `Token`
   - Implemented by: `AuthRepositoryImpl`

4. **Token**
   - No dependencies
   - Used by: `TokenStorage`, `AuthRepository`

## Models and Classes

### Data Models
- **[`Token`](../domain/models/token.dart)**
  - Data class for managing authentication tokens
  - Contains `accessToken` and `refreshToken` fields
  - Implements JSON serialization/deserialization

### Storage Classes
- **[`TokenStorage`](../data/storages/token_storage.dart)**
  - Handles secure storage of authentication tokens
  - Manages both access and refresh tokens
  - Implements caching mechanism

### Repository Classes
- **[`AuthRepository`](../domain/repositories/auth_repository.dart)**
  - Interface defining authentication operations
  - Abstract class for auth repository implementations
- **[`AuthRepositoryImpl`](../data/repositories/auth_repository_impl.dart)**
  - Concrete implementation of AuthRepository
  - Handles actual authentication logic

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
final tokenStorage = Get.find<TokenStorage>();

// Save tokens
await tokenStorage.saveToken(Token(
  accessToken: 'your_access_token',
  refreshToken: 'your_refresh_token'
));

// Get tokens
final token = await tokenStorage.getToken();
if (token != null) {
  final accessToken = token.accessToken;
  final refreshToken = token.refreshToken;
}
```

## Notes
- The module uses GetX for dependency injection
- Token storage is implemented using secure storage
- The module is designed to be easily pluggable into any Flutter application
- Both access token and refresh token are stored securely using JSON serialization