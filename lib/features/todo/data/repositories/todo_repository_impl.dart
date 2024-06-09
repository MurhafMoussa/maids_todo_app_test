import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/errors/exception_handler.dart';
import 'package:maids_todo_app_test/core/networking/connectivity.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/core/typedefs/result.dart';
import 'package:maids_todo_app_test/features/todo/data/data_sources/todo_local_data_source.dart';
import 'package:maids_todo_app_test/features/todo/data/data_sources/todo_remote_data_source.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/pagination_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/repositories/todo_repository.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(
    this._todoRemoteDataSource,
    this._connectivity,
    this._todoLocalDataSource,
  );

  final TodoRemoteDataSource _todoRemoteDataSource;
  final TodoLocalDataSource _todoLocalDataSource;
  final Connectivity _connectivity;

  @override
  Future<Result<String>> add(AddTodoParam todo) async {
    if (!await _connectivity.isConnected) {
      return const Left(AppExceptions.noInternetConnection());
    }
    return await handleRepositoryCalls<String>(
      () async {
        await _todoRemoteDataSource.add(todo);
        return 'Todo added successfully';
      },
    );
  }

  @override
  Future<Result<String>> delete(IdParam param) async {
    if (!await _connectivity.isConnected) {
      return const Left(AppExceptions.noInternetConnection());
    }
    return await handleRepositoryCalls<String>(
      () async {
        await _todoRemoteDataSource.delete(param);
        return 'Todo deleted successfully';
      },
    );
  }

  @override
  Future<Result<String>> edit(EditTodoParam param) async {
    if (!await _connectivity.isConnected) {
      return const Left(AppExceptions.noInternetConnection());
    }
    return await handleRepositoryCalls<String>(
      () async {
        await _todoRemoteDataSource.edit(param);
        return 'Todo updated successfully';
      },
    );
  }

  @override
  Future<Result<PaginationEntity>> getAll(
    PageParam param,
  ) async {
    if (!await _connectivity.isConnected) {
      return await handleRepositoryCalls<PaginationEntity>(
        () async {
          final todos = await _todoLocalDataSource.getAll(
            param,
          );

          return todos.toEntity();
        },
      );
    }
    return await handleRepositoryCalls<PaginationEntity>(
      () async {
        final response = await _todoRemoteDataSource.getAll(param);
        await _todoLocalDataSource.bulkSave(response.todos);
        return response.toEntity();
      },
    );
  }
}
