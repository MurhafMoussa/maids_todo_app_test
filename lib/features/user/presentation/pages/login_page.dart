import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_todo_app_test/core/constants/assets_manager.dart';
import 'package:maids_todo_app_test/core/constants/border_radius_manager.dart';
import 'package:maids_todo_app_test/core/constants/box_shadow_manager.dart';
import 'package:maids_todo_app_test/core/constants/padding_manager.dart';
import 'package:maids_todo_app_test/core/constants/sizes_manager.dart';
import 'package:maids_todo_app_test/core/navigation/nav.dart';
import 'package:maids_todo_app_test/core/states/handle_standard_bloc_listener.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/custom_textfield.dart';
import 'package:maids_todo_app_test/features/todo/presentation/pages/todos_page.dart';
import 'package:maids_todo_app_test/features/user/presentation/manager/user_cubit.dart';
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
    final loginCubit = context.read<UserCubit>();
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
            child: BlocListener<UserCubit, StandardState<String>>(
              listener: (context, state) {
                handleStandardBlocListener(
                  state,
                  context,
                  onSuccess: () {
                    Nav.to(TodosPage.routeName, context: context);
                  },
                );
              },
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
          ),
        ),
      ),
    );
  }
}
