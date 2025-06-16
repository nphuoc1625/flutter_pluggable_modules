# Getting Started with Auth Module

## 1. Initialize Module
```dart
void main() {
  // Initialize auth module
  AuthModule.inject();
  
  runApp(MyApp());
}
```

## 2. Core Methods

### Login
```dart
// Get repository instance
final authRepository = Get.find<AuthRepository>();

// Login with email and password
final result = await authRepository.loginWithEmail(
  'user@example.com',
  'password123'
);

// Handle result
result.fold(
  (token) {
    // Login successful
    print('Logged in successfully');
  },
  (error) {
    // Login failed
    print('Login failed: ${error.message}');
  }
);
```

### Check Login Status
```dart
// Check if user is logged in
final result = await authRepository.getToken();
if (result.isSuccess) {
  print('User is logged in');
} else {
  print('User is not logged in');
}
```

### Logout
```dart
// Logout user
final result = await authRepository.deleteToken();
if (result.isSuccess) {
  print('Logged out successfully');
} else {
  print('Logout failed: ${result.error?.message}');
}
```

## 3. Error Handling

### Basic Error Handling
```dart
try {
  final result = await authRepository.loginWithEmail(email, password);
  result.fold(
    (token) => print('Success: ${token.accessToken}'),
    (error) => print('Error: ${error.message}')
  );
} catch (e) {
  print('Unexpected error: $e');
}
```

### Common Error Types
```dart
// Handle specific errors
if (error is LoginError) {
  print('Login failed: ${error.message}');
} else if (error is TokenError) {
  print('Token error: ${error.message}');
} else if (error is NetworkError) {
  print('Network error: ${error.message}');
}
```