import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/core/usecases/usecase.dart';
import 'package:maids_todo_app_test/features/user/domain/repositories/user_facade.dart';

@lazySingleton
class Login extends UseCase<String, LoginParam> {
  const Login(this._userFacade);

  final UserFacade _userFacade;
  @override
  Future<Either<AppExceptions, String>> call(LoginParam params) async {
    return await _userFacade.login(params);
  }
}