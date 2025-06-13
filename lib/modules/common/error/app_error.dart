abstract class AppError {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppError(this.message, {this.code, this.originalError});

  @override
  String toString() =>
      '${runtimeType.toString()}: $message${code != null ? ' (Code: $code)' : ''}';
}

class UnknownError extends AppError {
  UnknownError(super.message, {super.code, super.originalError});
}

class NetworkError extends AppError {
  NetworkError(super.message, {super.code, super.originalError});
}

class StorageError extends AppError {
  StorageError(super.message, {super.code, super.originalError});
}
