import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/features/user/domain/use_cases/login.dart';

@injectable
class LoginCubit extends Cubit<StandardState<String>> {
  LoginCubit(this._login) : super(const StandardState.initial());
  final Login _login;
  Future<void> login(LoginParam param) async {
    emit(const StandardState.loading());
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
}
