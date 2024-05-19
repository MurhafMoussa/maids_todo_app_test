import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/networking/api_consumer.dart';
import 'package:maids_todo_app_test/core/networking/end_points.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/features/todo/data/models/pagination_model.dart';
import 'package:maids_todo_app_test/features/todo/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<PaginationModel> getAll(
    PageParam param,
  );
  Future<TodoModel> edit(
    EditTodoParam param,
  );
  Future<TodoModel> add(
    AddTodoParam todo,
  );
  Future<TodoModel> delete(
    IdParam param,
  );
}

@LazySingleton(as: TodoRemoteDataSource)
class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  const TodoRemoteDataSourceImpl(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<TodoModel> add(AddTodoParam todo) async {
    final response =
        await _apiConsumer.post('${EndPoints.todos}add', body: todo.toJson());
    return TodoModel.fromJson(response);
  }

  @override
  Future<TodoModel> delete(IdParam param) async {
    final response = await _apiConsumer.delete(
      '${EndPoints.todos}${param.id}',
    );
    return TodoModel.fromJson(response);
  }

  @override
  Future<TodoModel> edit(EditTodoParam param) async {
    final response = await _apiConsumer.put(
      '${EndPoints.todos}${param.id}',
      body: param.toJson(),
    );
    return TodoModel.fromJson(response);
  }

  @override
  Future<PaginationModel> getAll(PageParam param) async {
    final response = await _apiConsumer.get(
      EndPoints.todos,
      queryParameters: param.toJson(),
    );
    return PaginationModel.fromJson(
      response,
    );
  }
}
