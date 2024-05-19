part of 'todos_getter_cubit.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class TodosGetterState with _$TodosGetterState {
  const factory TodosGetterState.loading() = _Loading;
  const factory TodosGetterState.success(
      {required List<TodoEntity> todos, required bool canLoadMore}) = _Success;
  const factory TodosGetterState.error({
    required AppExceptions exception,
    required List<TodoEntity> oldTodos,
  }) = _Error;
}
