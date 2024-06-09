import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:maids_todo_app_test/core/constants/padding_manager.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/navigation/nav.dart';
import 'package:maids_todo_app_test/core/states/handle_standard_bloc_listener.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todo_operations_cubit.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todos_getter_cubit.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todos_getter_state.dart';
import 'package:maids_todo_app_test/features/todo/presentation/widgets/add_todo_bottom_sheet_content.dart';
import 'package:maids_todo_app_test/features/todo/presentation/widgets/todo.dart';
import 'package:maids_todo_app_test/features/user/presentation/manager/user_cubit.dart';
import 'package:maids_todo_app_test/features/user/presentation/pages/login_page.dart';

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
            create: (context) => getIt<TodosGetterCubit>()..getAllTodos(0),
          ),
          BlocProvider<TodoOperationsCubit>(
            create: (context) => getIt<TodoOperationsCubit>(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MultiBlocListener(
              listeners: [
                BlocListener<UserCubit, StandardState<String>>(
                  listener: (context, state) {
                    handleStandardBlocListener(
                      state,
                      context,
                      onSuccess: () {
                        Nav.to(LoginPage.routeName, context: context);
                      },
                    );
                  },
                ),
                BlocListener<TodoOperationsCubit, StandardState<String>>(
                  listener: (context, state) {
                    handleStandardBlocListener(state, context);
                  },
                ),
              ],
              child: Scaffold(
                floatingActionButton: _buildAddTodoButton(context),
                appBar: _buildAppBar(context),
                body: BlocBuilder<TodosGetterCubit, TodosGetterState>(
                  builder: (context, state) => state.when(
                    loadInProgress: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    loadSuccess: (todos, isLastPage) =>
                        PagedListView<int, TodoEntity>.separated(
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      pagingController:
                          context.read<TodosGetterCubit>().pagingController,
                      padding: PaddingManager.paddingAll16,
                      builderDelegate: PagedChildBuilderDelegate<TodoEntity>(
                        itemBuilder: (context, item, index) => Todo(todo: item),
                      ),
                    ),
                    loadFailure: (error) => Center(
                      child: Text(error),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: context.read<UserCubit>().logout,
        icon: const Icon(Icons.logout),
      ),
      title: Text(
        'My Todos',
        style: context.theme.textTheme.headlineLarge,
      ),
    );
  }

  FloatingActionButton _buildAddTodoButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
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
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
