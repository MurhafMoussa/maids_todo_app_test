import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/core/usecases/usecase.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/pagination_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/repositories/todo_repository.dart';

@lazySingleton
class GetAllTodos extends UseCase<PaginationEntity, PageParam> {
  const GetAllTodos(this._todoRepository);

  final TodoRepository _todoRepository;
  @override
  Future<Either<AppExceptions, PaginationEntity>> call(
    PageParam params,
  ) async {
    return await _todoRepository.getAll(params);
  }
}
