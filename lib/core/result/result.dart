/// Expected success/failure outcome for repository and application boundaries.
///
/// Keep failures typed and meaningful. Do not use a failure result to represent
/// a valid empty collection or ordinary absence when that is valid domain data.
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final AppFailure failure;
}

sealed class AppFailure {
  const AppFailure(this.message);

  /// Safe, user-appropriate or diagnostic-safe message; never include secrets.
  final String message;
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure(super.message);
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure(super.message);
}

final class TokenExpiredFailure extends AppFailure {
  const TokenExpiredFailure(super.message);
}

final class RateLimitFailure extends AppFailure {
  const RateLimitFailure(super.message, {this.retryAfterSeconds});

  final int? retryAfterSeconds;
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure(super.message);
}

final class ServerFailure extends AppFailure {
  const ServerFailure(super.message);
}

final class ParsingFailure extends AppFailure {
  const ParsingFailure(super.message);
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(super.message);
}
