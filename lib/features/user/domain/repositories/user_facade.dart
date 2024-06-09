import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/core/typedefs/result.dart';

abstract class UserFacade {
  Future<Result<String>> login(LoginParam param);
  Future<Result<String>> logout();
}
