import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/core/typedefs/result.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/pagination_entity.dart';

abstract class TodoRepository {
  Future<Result<PaginationEntity>> getAll(
    PageParam param,
  );
  Future<Result<String>> edit(
    EditTodoParam param,
  );
  Future<Result<String>> add(
    AddTodoParam todo,
  );
  Future<Result<String>> delete(
    IdParam param,
  );
}
