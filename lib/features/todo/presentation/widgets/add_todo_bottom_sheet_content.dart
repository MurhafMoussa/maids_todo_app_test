import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:maids_todo_app_test/core/constants/border_radius_manager.dart';
import 'package:maids_todo_app_test/core/constants/box_shadow_manager.dart';
import 'package:maids_todo_app_test/core/constants/padding_manager.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/navigation/nav.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/text_area_form_field/text_area_form_field.dart';
import 'package:maids_todo_app_test/core/ui/widgets/loading_widget.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todo_operations_cubit.dart';
import 'package:maids_todo_app_test/features/user/data/data_sources/user_local_data_source.dart';

class AddTodoBottomSheetContent extends StatelessWidget {
  const AddTodoBottomSheetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todoOperationsCubit = context.read<TodoOperationsCubit>();
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        margin: PaddingManager.paddingAll16,
        padding: PaddingManager.paddingAll16,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusManager.radiusAll16,
          color: Colors.white,
          boxShadow: [
            BoxShadowManager.richBlackOpacity003Blur16Offset0X4Y,
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add a todo',
              style: context.textTheme.headlineSmall,
            ),
            20.verticalSpace,
            TextAreaFormField(
              controller: todoOperationsCubit.textAreaController,
            ),
            20.verticalSpace,
            FilledButton(
              onPressed: () {
                final user = getIt<UserLocalDataSource>().getUser();
                todoOperationsCubit.add(
                  AddTodoParam(
                    userId: user!.id,
                    isCompleted: false,
                    todo: todoOperationsCubit.todoDescription,
                  ),
                );
              },
              child: BlocConsumer<TodoOperationsCubit, StandardState<String>>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: (_) {
                      Nav.pop(context);
                    },
                  );
                },
                builder: (context, state) => state.maybeWhen(
                  orElse: () => const Text('add'),
                  loading: () => const LoadingWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
