import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';

part 'standard_state.freezed.dart';

@freezed
class StandardState<T> with _$StandardState<T> {
  const factory StandardState.initial() = _Initial;
  const factory StandardState.loading() = _Loading;
  const factory StandardState.success(T successValue) = _Success;
  const factory StandardState.failure(AppExceptions exception) = _Failure;
}
