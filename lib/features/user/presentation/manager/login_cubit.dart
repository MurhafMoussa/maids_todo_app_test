import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/name_form_field/name_form_field_controller.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/password_form_fields/password_form_field_controller.dart';
import 'package:maids_todo_app_test/features/user/domain/use_cases/login.dart';

@injectable
class LoginCubit extends Cubit<StandardState<String>> {
  LoginCubit(this._login) : super(const StandardState.initial()) {
    passwordFormFieldController = PasswordFormFieldController.filled(
      onChange: (value) {
        password = value;
      },
    );
    nameFormFieldController = NameFormFieldController.filled(
      onChange: (value) {
        username = value;
      },
    );
  }
  final Login _login;

  late final NameFormFieldController nameFormFieldController;
  late final PasswordFormFieldController passwordFormFieldController;
  final GlobalKey<FormState> formKey = GlobalKey();
  String username = '';
  String password = '';

  Future<void> login() async {
    emit(const StandardState.loading());
    final param = LoginParam(
      expirationDateInMinutes: 30,
      username: username,
      password: password,
    );
    final response = await _login(param);
    response.fold(
      (l) => emit(StandardState.failure(l)),
      (r) => emit(StandardState.success(r)),
    );
  }

  @override
  Future<void> close() {
    nameFormFieldController.dispose();
    passwordFormFieldController.dispose();
    return super.close();
  }
}
