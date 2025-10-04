sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;

  const factory Result.error(T error) = Error._;
}

final class Ok<T> extends Result<T> {
  final T value;

  const Ok._(this.value);
}

final class Error<T> extends Result<T> {
  final T error;

  const Error._(this.error);
}
