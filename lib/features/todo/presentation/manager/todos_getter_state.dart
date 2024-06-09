import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';

part 'todos_getter_state.freezed.dart';

@freezed
class TodosGetterState with _$TodosGetterState {
  const factory TodosGetterState.loadInProgress() = TodosLoadInProgress;
  const factory TodosGetterState.loadSuccess(
      List<TodoEntity> todos, bool isLastPage,) = TodosLoadSuccess;
  const factory TodosGetterState.loadFailure(String error) = TodosLoadFailure;
}
