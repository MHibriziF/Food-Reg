part of '_client.dart';

T? cast<T>(dynamic x) => x is T ? x : null;

Failure _failureFromDioException(DioException e) {
  LoggerService.f(e.error.runtimeType);
  LoggerService.f(e.error.toString());
  LoggerService.f(e);
  LoggerService.f('Response status: ${e.response?.statusCode}');
  LoggerService.f('Response data: ${e.response?.data}');
  if (e.error is ArgumentError) {
    return GeneralFailure(message: kGenericErrorMessage);
  } else if (e.error is SocketException) {
    LoggerService.e('No Internet Connection');
    return NetworkFailure(message: kNoInternetMessage);
  } else if (e.error is TimeoutException) {
    LoggerService.e('Timeout');
    return TimeoutFailure(message: kGenericErrorMessage);
  } else if (e.error is FormatException) {
    LoggerService.e('Format Exception');
    return GeneralFailure(message: kGenericErrorMessage);
  } else if ((e.response?.statusCode ?? 0) == 403) {
    LoggerService.e('Unauthorized');
    return GeneralFailure(message: 'Unauthorized');
  } else if ((e.response?.statusCode ?? 0) == 404) {
    LoggerService.e('Not Found');
    return NotFoundFailure(
      message:
          cast<String>((e.response?.data['error'] as Map?)?['message']) ??
          cast<String>(e.response?.data['message']) ??
          'Not Found',
    );
  } else {
    final message = DioFailure.fromDioError(e).message;
    return GeneralFailure(message: message);
  }
}

Failure failureFromException(Object e) {
  if (e is DioException) {
    return _failureFromDioException(e);
  }
  // Raw exception text can expose hosts/paths — logged above, and the user
  // gets the generic message instead.
  LoggerService.e(e.runtimeType);
  LoggerService.e(e.toString());
  return GeneralFailure(message: kGenericErrorMessage);
}

Future<Either<Failure, T>> apiCall<T>(Future<T> t) async {
  try {
    final futureCall = await t;
    return Right(futureCall);
  } catch (e) {
    return Left(failureFromException(e));
  }
}
