# Domain Layer

## Step 1: Define Domain Models
- Place in `domain/models/`
- Example:
```dart
class FeatureModel {
  final String id;
  final String name;
  // ...
}
```

## Step 2: Define Error Types
- Place in `domain/errors/`
- Use centralized error codes from `common/error/error_codes.dart`
- Example:
```dart
class FeatureError extends AppError { ... }
class FeatureNotFoundError extends FeatureError { ... }
```

## Step 3: Define Repository Interface
- Place in `domain/repositories/`
- Use `Result` for error handling
- Example:
```dart
abstract class FeatureRepository {
  Future<Result<FeatureModel, FeatureError>> getFeature(String id);
}
```

## Explanation

- **Domain Models**: Represent the core business logic and data structures.
- **Error Types**: Define specific error cases for the feature.
- **Repository Interface**: Define the contract for data operations. 