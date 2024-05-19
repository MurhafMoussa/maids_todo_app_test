import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_todo_app_test/core/constants/assets_manager.dart';
import 'package:maids_todo_app_test/core/constants/border_radius_manager.dart';
import 'package:maids_todo_app_test/core/constants/box_shadow_manager.dart';
import 'package:maids_todo_app_test/core/constants/padding_manager.dart';
import 'package:maids_todo_app_test/core/constants/sizes_manager.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/navigation/nav.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/ui/widgets/display_messages_widgets.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/custom_textfield.dart';
import 'package:maids_todo_app_test/features/todo/presentation/pages/todos_page.dart';
import 'package:maids_todo_app_test/features/user/presentation/manager/login_cubit.dart';
import 'package:maids_todo_app_test/features/user/presentation/widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = 'LoginPage';
  static const String urlPath = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: PaddingManager.paddingAll16,
            padding: PaddingManager.paddingAll16,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusManager.radiusAll16,
              color: Colors.white,
              boxShadow: [BoxShadowManager.richBlackOpacity003Blur16Offset0X4Y],
            ),
            child: BlocProvider<LoginCubit>(
              create: (context) => getIt<LoginCubit>(),
              child: Builder(
                builder: (context) {
                  final loginCubit = context.read<LoginCubit>();

                  return BlocListener<LoginCubit, StandardState<String>>(
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
                          Nav.to(TodosPage.routeName, context: context);
                        },
                      );
                    },
                    child: Form(
                      key: loginCubit.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AssetsManager.pngAppIcon,
                            height: SizesManager.imageSize70,
                          ),
                          CustomTextField(
                            controller: loginCubit.nameFormFieldController,
                          ),
                          10.verticalSpace,
                          CustomTextField(
                            controller: loginCubit.passwordFormFieldController,
                          ),
                          20.verticalSpace,
                          const LoginButton(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
