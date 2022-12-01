import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.data(T data) = ResultData;

  const factory Result.failure(Object? failure) = ResultFailure;
}

extension ResultMethods<T> on Result<T> {
  T getOrCrash() {
    final result = this;
    if (result is ResultData<T>) {
      return result.data;
    }
    if (result is ResultFailure<T>) {
      final exception = result.failure;
      if (exception is Object) {
        throw exception;
      }
    }
    throw Exception('Unknown error');
  }
}
