# Feature Implementation Guide

This guide provides a step-by-step approach to implementing new features following the modular architecture pattern used in this project.

## Steps Overview

1. [Project Structure](feature_guide_structure.md)
2. [Domain Layer](feature_guide_domain.md)
3. [Data Layer](feature_guide_data.md)
4. [Error Handling](feature_guide_error_handling.md)
5. [Testing](feature_guide_testing.md)
6. [Documentation](feature_guide_documentation.md)

## Table of Contents
1. [Project Structure](#project-structure)
2. [Implementation Steps](#implementation-steps)
3. [Error Handling](#error-handling)
4. [Testing Guidelines](#testing-guidelines)
5. [Documentation](#documentation)

## Project Structure

### Module Structure
```
module_name/
├── module_name.dart              # Main entry point
├── data/
│   ├── repositories/            # Repository implementations
│   └── storages/               # Local storage implementations
├── domain/
│   ├── errors/                 # Domain-specific errors
│   ├── models/                 # Domain models
│   └── repositories/           # Repository interfaces
└── docs/                       # Module documentation
```

### Dependencies
- **get**: For dependency injection
- **common**: For shared functionality
  - `Result`: Error handling
  - `AppError`: Base error class
  - `ErrorCodes`: Centralized error codes

## Implementation Steps

### 1. Define Domain Models
Create your domain models in `domain/models/`:
```dart
// feature_model.dart
class FeatureModel {
  final String id;
  final String name;
  
  const FeatureModel({
    required this.id,
    required this.name,
  });
  
  // Add JSON serialization if needed
}
```

### 2. Define Error Types
Create error classes in `domain/errors/`:
```dart
// feature_error.dart
import 'package:your_app/modules/common/error/app_error.dart';
import 'package:your_app/modules/common/error/error_codes.dart';

class FeatureError extends AppError {
  FeatureError(super.message, {super.code, super.originalError});
}

class SpecificFeatureError extends FeatureError {
  SpecificFeatureError({String? code, dynamic originalError})
    : super('Error message', code: code ?? FeatureErrorCodes.specificError, originalError: originalError);
}
```

### 3. Define Repository Interface
Create repository interface in `domain/repositories/`:
```dart
// feature_repository.dart
import 'package:your_app/modules/common/result/result.dart';
import '../models/feature_model.dart';
import '../errors/feature_error.dart';

abstract class FeatureRepository {
  Future<Result<FeatureModel, FeatureError>> getFeature(String id);
  Future<Result<void, FeatureError>> saveFeature(FeatureModel feature);
}
```

### 4. Implement Storage (if needed)
Create storage implementation in `data/storages/`:
```dart
// feature_storage.dart
import 'package:your_app/modules/common/storage/storage.dart';
import '../../domain/models/feature_model.dart';

class FeatureStorage {
  final Storage _storage;
  
  FeatureStorage(this._storage);
  
  Future<void> saveFeature(FeatureModel feature) async {
    // Implementation
  }
  
  Future<FeatureModel?> getFeature() async {
    // Implementation
  }
}
```

### 5. Implement Repository
Create repository implementation in `data/repositories/`:
```dart
// feature_repository_impl.dart
import 'package:your_app/modules/common/error/error_codes.dart';
import 'package:your_app/modules/common/result/result.dart';
import '../../domain/models/feature_model.dart';
import '../../domain/errors/feature_error.dart';
import '../../domain/repositories/feature_repository.dart';
import '../storages/feature_storage.dart';

class FeatureRepositoryImpl implements FeatureRepository {
  final FeatureStorage _storage;
  
  FeatureRepositoryImpl(this._storage);
  
  @override
  Future<Result<FeatureModel, FeatureError>> getFeature(String id) async {
    try {
      // Implementation
    } catch (e) {
      // Error handling
    }
  }
}
```

### 6. Create Module Entry Point
Create main module file:
```dart
// feature_module.dart
import 'package:get/get.dart';
import 'data/repositories/feature_repository_impl.dart';
import 'domain/repositories/feature_repository.dart';

class FeatureModule {
  static void inject() {
    Get.lazyPut<FeatureRepository>(
      () => FeatureRepositoryImpl(Get.find()),
    );
  }
}
```

## Error Handling

### 1. Define Error Codes
Add your module's error codes to `common/error/error_codes.dart`:
```dart
class FeatureErrorCodes {
  const FeatureErrorCodes._();
  
  static const String notFound = 'FEATURE_NOT_FOUND';
  static const String invalidData = 'INVALID_FEATURE_DATA';
}
```

### 2. Error Handling Pattern
Follow this pattern in repository implementations:
```dart
try {
  // Business logic
} catch (e) {
  if (e is FeatureError) {
    return Result.error(e);
  }
  return Result.error(FeatureError('Error message', originalError: e));
}
```

### 3. Server Response Handling
```dart
if (response['error'] != null) {
  final error = response['error'];
  switch (error['code']) {
    case FeatureErrorCodes.notFound:
      return Result.error(FeatureNotFoundError());
    default:
      return Result.error(FeatureError(error['message']));
  }
}
```

## Testing Guidelines

### 1. Unit Tests
Create tests for:
- Domain models
- Repository implementations
- Storage implementations

### 2. Test Structure
```
test/
├── data/
│   ├── repositories/
│   └── storages/
└── domain/
    ├── models/
    └── errors/
```

### 3. Test Examples
```dart
// feature_repository_test.dart
void main() {
  late FeatureRepository repository;
  
  setUp(() {
    // Setup
  });
  
  test('should return feature when found', () async {
    // Test implementation
  });
  
  test('should return error when not found', () async {
    // Test implementation
  });
}
```

## Documentation

### 1. Module Documentation
Create `docs/feature_module.md`:
```markdown
# Feature Module

## Overview
Brief description of the feature module.

## Dependencies
List of dependencies.

## Usage
Code examples and usage patterns.

## Error Handling
Error types and handling patterns.
```

### 2. Code Documentation
- Add documentation comments to all public APIs
- Include examples in documentation
- Document error cases

### 3. API Documentation
- Document all public methods
- Include parameter descriptions
- Document return types and possible errors

## Best Practices

1. **Error Handling**
   - Always use `Result` type for operations that can fail
   - Create specific error types for different error cases
   - Use centralized error codes

2. **Dependency Injection**
   - Use GetX for dependency injection
   - Keep dependencies explicit in constructors
   - Follow the dependency tree

3. **Code Organization**
   - Keep files small and focused
   - Follow the module structure
   - Use proper naming conventions

4. **Testing**
   - Write tests for all public APIs
   - Test error cases
   - Use proper test organization

5. **Documentation**
   - Keep documentation up to date
   - Include examples
   - Document error cases

## References

- [Auth Module](../auth/docs/auth_module.md) - Example implementation
- [Common Module](../common/docs/common_module.md) - Shared functionality
- [Error Handling Guide](../common/docs/error_handling.md) - Error handling patterns 