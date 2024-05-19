import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/get_all_todos.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'todos_getter_cubit.freezed.dart';
part 'todos_getter_state.dart';

const limit = 20;
const initialPage = 0;

@lazySingleton
class TodosGetterCubit extends Cubit<TodosGetterState> {
  TodosGetterCubit(this._getAllTodos) : super(const TodosGetterState.loading());
  final GetAllTodos _getAllTodos;
  int currentPage = initialPage;
  bool canLoadMoreData = true;
  Future<void> getAllTodos() async {
    /// simple condition to check if we reached the last page so we dont
    /// make extra api calls
    if (!canLoadMoreData) {
      return;
    }
    PageParam params = PageParam(skip: limit * currentPage, pageLength: limit);
    final response = await _getAllTodos(params);
    response.fold(
      (l) => emit(
        TodosGetterState.error(
          exception: l,
          oldTodos: state.maybeWhen(
            orElse: () => [],
            success: (todos, canLoadMore) => todos,
          ),
        ),
      ),
      (newTodos) {
        canLoadMoreData = newTodos.total >
            state.maybeWhen(
              orElse: () => 1,
              success: (todos, _) => todos.length,
            );

        ///after each successful api call we increase the current page
        currentPage++;
        emit(
          TodosGetterState.success(
            todos: state.maybeWhen(
              ///this case represents when calling the api for the first time
              ///the state list will be empty so we directly add the incoming data
              ///to the empty list
              orElse: () => [...newTodos.todos],

              ///this case represents the state when it contains todos so we
              ///add the incoming todos to the existing ones
              success: (oldTodos, _) => [...oldTodos, ...newTodos.todos],
            ),
            canLoadMore: canLoadMoreData,
          ),
        );
      },
    );
  }

  final RefreshController successRefreshController = RefreshController();
  final RefreshController errorRefreshController = RefreshController();
  @override
  Future<void> close() {
    successRefreshController.dispose();
    errorRefreshController.dispose();
    return super.close();
  }
}
