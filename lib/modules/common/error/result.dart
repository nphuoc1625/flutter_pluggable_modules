/// A class that represents either a success or an error.
class Result<T, E> {
  final T? _value;
  final E? _error;
  final bool _isSuccess;

  /// Creates a successful result with a value.
  Result.success(T value) : _value = value, _error = null, _isSuccess = true;

  /// Creates an error result with an error.
  Result.error(E error) : _value = null, _error = error, _isSuccess = false;

  /// Returns true if this is a success result.
  bool get isSuccess => _isSuccess;

  /// Returns true if this is an error result.
  bool get isError => !_isSuccess;

  /// Gets the value if this is a success result.
  /// Throws an [Exception] if this is an error result.
  T get value {
    if (!_isSuccess) {
      throw Exception('Cannot get value from error result');
    }
    return _value!;
  }

  /// Gets the error if this is an error result.
  /// Throws an [Exception] if this is a success result.
  E get error {
    if (_isSuccess) {
      throw Exception('Cannot get error from success result');
    }
    return _error!;
  }

  /// Maps the value of a success result using the given function.
  /// Returns a new success result with the mapped value.
  /// If this is an error result, returns a new error result with the same error.
  Result<U, E> map<U>(U Function(T value) mapper) {
    if (_isSuccess) {
      return Result.success(mapper(_value!));
    }
    return Result.error(_error!);
  }

  /// Maps the error of an error result using the given function.
  /// Returns a new error result with the mapped error.
  /// If this is a success result, returns a new success result with the same value.
  Result<T, F> mapError<F>(F Function(E error) mapper) {
    if (_isSuccess) {
      return Result.success(_value!);
    }
    return Result.error(mapper(_error!));
  }

  /// Executes the given function if this is a success result.
  /// Returns this result unchanged.
  Result<T, E> onSuccess(void Function(T value) callback) {
    if (_isSuccess) {
      callback(_value!);
    }
    return this;
  }

  /// Executes the given function if this is an error result.
  /// Returns this result unchanged.
  Result<T, E> onError(void Function(E error) callback) {
    if (!_isSuccess) {
      callback(_error!);
    }
    return this;
  }
}
