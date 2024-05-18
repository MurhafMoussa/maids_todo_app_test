import 'package:dartz/dartz.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/base_params.dart';

abstract class UseCase<Type, Params extends BaseParams> {
  const UseCase();
  Future<Either<AppExceptions, Type>> call(Params params);
}
