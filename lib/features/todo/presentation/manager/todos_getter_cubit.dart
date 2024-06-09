import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/get_all_todos.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todos_getter_state.dart';

@injectable
class TodosGetterCubit extends Cubit<TodosGetterState> {
  TodosGetterCubit(this._getAllTodosUseCase)
      : super(const TodosGetterState.loadInProgress()) {
    pagingController.addPageRequestListener((pageKey) {
      getAllTodos(pageKey);
    });
  }
  final GetAllTodos _getAllTodosUseCase;
  final PagingController<int, TodoEntity> pagingController =
      PagingController(firstPageKey: 0);
  bool isLastPage = false;
  Future<void> getAllTodos(int currentPage, {int pageSize = 20}) async {
    PageParam params = PageParam(skip: currentPage, pageLength: pageSize);
    final response = await _getAllTodosUseCase(params);
    response.fold((l) {
      pagingController.error = AppExceptions.getErrorMessage(l);
      emit(TodosGetterState.loadFailure(AppExceptions.getErrorMessage(l)));
    }, (paginationEntity) {
      final newTodos = paginationEntity.todos;

      isLastPage = newTodos.length < pageSize;
      debugPrint(isLastPage.toString());
      debugPrint(newTodos.length.toString());
      debugPrint(pageSize.toString());
      if (isLastPage) {
        pagingController.appendLastPage(newTodos);
      } else {
        final nextPageKey = currentPage + newTodos.length;
        pagingController.appendPage(newTodos, nextPageKey);
      }
      emit(TodosGetterState.loadSuccess(newTodos, isLastPage));
    });
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
