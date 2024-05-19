import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:maids_todo_app_test/core/constants/padding_manager.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/navigation/nav.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/ui/widgets/display_messages_widgets.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todo_operations_cubit.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todos_getter_cubit.dart';
import 'package:maids_todo_app_test/features/todo/presentation/widgets/add_todo_bottom_sheet_content.dart';
import 'package:maids_todo_app_test/features/todo/presentation/widgets/custom_pagination_widget.dart';
import 'package:maids_todo_app_test/features/todo/presentation/widgets/todo.dart';
import 'package:maids_todo_app_test/features/user/presentation/manager/user_cubit.dart';
import 'package:maids_todo_app_test/features/user/presentation/pages/login_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  static const String routeName = 'TodosPage';
  static const String urlPath = '/todos';

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<TodosGetterCubit>(
            create: (context) => getIt<TodosGetterCubit>()..getAllTodos(),
          ),
          BlocProvider<TodoOperationsCubit>(
            create: (context) => getIt<TodoOperationsCubit>(),
          ),
        ],
        child: Builder(
          builder: (context) {
            final todosGetterCubit = context.read<TodosGetterCubit>();

            return BlocListener<UserCubit, StandardState<String>>(
              listener: (context, state) {
                state.whenOrNull(
                  failure: (exception) {
                    showErrorSnackBar(
                      AppExceptions.getErrorMessage(exception),
                      context,
                    );
                  },
                  success: (successValue) {
                    showSuccessSnackBar(successValue, context);
                    Nav.to(LoginPage.routeName, context: context);
                  },
                );
              },
              child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    addTodoBottomSheet(
                      context,
                    );
                  },
                  child: const Icon(
                    Icons.add,
                  ),
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: PaddingManager.paddingHorizontal16Top56,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: context.read<UserCubit>().logout,
                            icon: const Icon(Icons.logout),
                          ),
                          Center(
                            child: Text(
                              'My Todos',
                              style: context.theme.textTheme.headlineLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocConsumer<TodosGetterCubit, TodosGetterState>(
                        listener: (context, state) => state.whenOrNull(
                          success: (_, canLoadMoreData) {
                            todosGetterCubit.successRefreshController
                                .refreshCompleted();
                            if (!canLoadMoreData) {
                              todosGetterCubit.successRefreshController
                                  .loadNoData();
                            } else {
                              todosGetterCubit.successRefreshController
                                  .loadComplete();
                            }
                            return null;
                          },
                        ),
                        builder: (context, state) => state.when(
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          success: (todos, canLoadMore) =>
                              buildCustomPaginationWidget(
                            todosGetterCubit,
                            todos,
                            todosGetterCubit.successRefreshController,
                          ),
                          error: (exception, oldTodos) =>
                              buildCustomPaginationWidget(
                            todosGetterCubit,
                            oldTodos,
                            todosGetterCubit.successRefreshController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  void addTodoBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<TodoOperationsCubit>(),
          child: const AddTodoBottomSheetContent(),
        );
      },
    );
  }

  CustomPaginationWidget buildCustomPaginationWidget(
    TodosGetterCubit todosGetterCubit,
    List<TodoEntity> todos,
    RefreshController controller,
  ) {
    return CustomPaginationWidget(
      refreshController: controller,
      onLoading: () async {
        todosGetterCubit.getAllTodos();
      },
      listTobePaginated: ListView.separated(
        separatorBuilder: (context, index) => 10.verticalSpace,
        padding: PaddingManager.paddingAll16,
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Todo(todo: todo);
        },
      ),
    );
  }
}
