import 'dart:developer';

import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:rxdart/rxdart.dart';

Future<Result<T>> wrapFutureToResult<T>(Future<T> Function() func) async {
  try {
    final data = await func();
    return Result.data(data);
  } catch (exception, stackTrace) {
    return _resultFromFailure(exception, stackTrace);
  }
}

Stream<Result<T>> wrapStreamToResult<T>(Stream<T> Function() func) {
  return func().map((v) => Result.data(v)).onErrorReturnWith(
      (exception, stackTrace) => _resultFromFailure(exception, stackTrace));
}

ResultFailure<T> _resultFromFailure<T>(
    Object? failure, StackTrace? stackTrace) {
  log(
    failure.toString(),
    error: failure,
    stackTrace: stackTrace,
    name: 'ResultWrapper',
  );
  return ResultFailure<T>(failure);
}
