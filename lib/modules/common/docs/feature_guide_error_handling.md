# Error Handling

- Add error codes to `common/error/error_codes.dart`
- Use error codes in error classes and repository implementations
- Always return `Result.success` or `Result.error`
- Example error handling in repository:
```dart
try {
  // ...
} catch (e) {
  if (e is FeatureError) return Result.error(e);
  return Result.error(FeatureError('Unknown error', originalError: e));
}
```

## Explanation

- **Error Codes**: Centralize error codes for consistency and reusability.
- **Error Handling**: Use try-catch blocks to handle exceptions and map them to domain-specific errors. 