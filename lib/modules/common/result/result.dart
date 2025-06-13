class Result<T, E> {
  final T? _success;
  final E? _error;
  final bool _isSuccess;

  Result._(this._success, this._error, this._isSuccess);

  factory Result.success(T value) => Result._(value, null, true);
  factory Result.error(E error) => Result._(null, error, false);

  bool get isSuccess => _isSuccess;
  bool get isError => !_isSuccess;

  T get success {
    if (!isSuccess) {
      throw Exception('Cannot get success value from error result');
    }
    return _success as T;
  }

  E get error {
    if (!isError) throw Exception('Cannot get error value from success result');
    return _error as E;
  }

  R fold<R>(R Function(T) onSuccess, R Function(E) onError) {
    if (isSuccess) {
      return onSuccess(_success as T);
    } else {
      return onError(_error as E);
    }
  }
}
