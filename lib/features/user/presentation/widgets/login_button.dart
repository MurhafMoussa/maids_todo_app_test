import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/ui/widgets/loading_widget.dart';
import 'package:maids_todo_app_test/features/user/presentation/manager/user_cubit.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    super.key,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<UserCubit>();

    return FilledButton(
      onPressed: loginCubit.login,
      child: BlocBuilder<UserCubit, StandardState<String>>(
        builder: (context, state) => state.maybeWhen(
          orElse: () => const Text('login'),
          loading: () {
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
