# Testing

- Write unit tests for models, repositories, and storage
- Use the following structure:
```
test/
├── data/
│   ├── repositories/
│   └── storages/
└── domain/
    ├── models/
    └── errors/
```
- Example test:
```dart
test('should return feature when found', () async { ... });
```

## Explanation

- **Unit Tests**: Ensure each component works as expected.
- **Test Structure**: Organize tests to mirror the module structure for clarity. 