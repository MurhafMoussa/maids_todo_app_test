import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/core/params/no_params.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/name_form_field/name_form_field_controller.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/password_form_fields/password_form_field_controller.dart';
import 'package:maids_todo_app_test/features/user/domain/use_cases/login.dart';
import 'package:maids_todo_app_test/features/user/domain/use_cases/logout.dart';

@injectable
class UserCubit extends Cubit<StandardState<String>> {
  UserCubit(
    this._login,
    this._logout,
  ) : super(const StandardState.initial()) {
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
  final Logout _logout;
  late final NameFormFieldController nameFormFieldController;
  late final PasswordFormFieldController passwordFormFieldController;

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
      (l) {
        emit(StandardState.failure(l));
      },
      (r) {
        emit(StandardState.success(r));
      },
    );
  }

  Future<void> logout() async {
    emit(const StandardState.loading());
    final response = await _logout(const NoParams());
    response.fold(
      (l) {
        emit(StandardState.failure(l));
      },
      (r) {
        emit(StandardState.success(r));
      },
    );
  }

  bool get formIsValid =>
      nameFormFieldController.key.currentState != null &&
      nameFormFieldController.key.currentState!.validate() &&
      passwordFormFieldController.key.currentState != null &&
      passwordFormFieldController.key.currentState!.validate();
  @override
  Future<void> close() {
    nameFormFieldController.onClose();
    passwordFormFieldController.onClose();
    return super.close();
  }
}
