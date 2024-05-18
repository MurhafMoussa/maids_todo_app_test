import 'package:dartz/dartz.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';

typedef Result<T> = Either<AppExceptions, T>;

Future<Result<T>> handleRepositoryCalls<T>(
    Future<T> Function() operation) async {
  try {
    final response = await operation();

    return Right(response);
  } catch (error, stackTrace) {
    return Left(AppExceptions.getException(error, stackTrace));
  }
}
