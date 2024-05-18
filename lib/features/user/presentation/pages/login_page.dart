import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_todo_app_test/core/constants/border_radius_manager.dart';
import 'package:maids_todo_app_test/core/constants/box_shadow_manager.dart';
import 'package:maids_todo_app_test/core/constants/padding_manager.dart';
import 'package:maids_todo_app_test/core/di/service_locator.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/ui/widgets/display_messages_widgets.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/custom_textfield.dart';
import 'package:maids_todo_app_test/core/ui/widgets/loading_widget.dart';
import 'package:maids_todo_app_test/features/user/presentation/manager/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String routeName = 'LoginPage';
  static const String urlPath = '/login';

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
                          CustomTextField(
                            controller: loginCubit.nameFormFieldController,
                          ),
                          10.verticalSpace,
                          CustomTextField(
                            controller: loginCubit.passwordFormFieldController,
                          ),
                          20.verticalSpace,
                          FilledButton(
                            onPressed: loginCubit.login,
                            child:
                                BlocBuilder<LoginCubit, StandardState<String>>(
                              builder: (context, state) => state.maybeWhen(
                                orElse: () => const Text('login'),
                                loading: () {
                                  return const LoadingWidget();
                                },
                              ),
                            ),
                          ),
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
