import 'package:dartz/dartz.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';

typedef Result<T> = Either<AppExceptions, T>;
