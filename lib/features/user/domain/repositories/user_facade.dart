import 'package:dartz/dartz.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';

abstract class UserFacade {
  Future<Either<AppExceptions, String>> login(LoginParam param);
  Future<Either<AppExceptions, Unit>> refreshToken();
}
