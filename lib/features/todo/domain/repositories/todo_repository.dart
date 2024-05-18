import 'package:dartz/dartz.dart';
import 'package:maids_todo_app_test/core/entities/pagination_entity.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Either<AppExceptions, PaginationEntity<TodoEntity>>> getAll(
    PageParam param,
  );
  Future<Either<AppExceptions, String>> edit(
    EditTodoParam param,
  );
  Future<Either<AppExceptions, String>> add(
    AddTodoParam todo,
  );
  Future<Either<AppExceptions, String>> delete(
    int todoId,
  );
}
