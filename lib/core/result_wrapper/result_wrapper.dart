import 'dart:developer';

import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:rxdart/rxdart.dart';

Future<Result<T>> wrapFutureToResult<T>(Future<T> Function() func) async {
  try {
    final v = await func();
    return Result.success(v);
  } catch (e) {
    log('wrapFutureToResult: error caught $e');
    return Result.error(e);
  }
}

Stream<Result<T>> wrapStreamToResult<T>(Stream<T> Function() func) {
  return func()
      .map((v) => Result.success(v))
      .onErrorReturnWith((e, _) => Result.error(e));
}
