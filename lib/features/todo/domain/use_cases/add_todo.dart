import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/usecases/usecase.dart';
import 'package:maids_todo_app_test/features/todo/domain/repositories/todo_repository.dart';

@lazySingleton
class AddTodo extends UseCase<String, AddTodoParam> {
  const AddTodo(this._todoRepository);

  final TodoRepository _todoRepository;
  @override
  Future<Either<AppExceptions, String>> call(AddTodoParam params) async {
    return await _todoRepository.add(params);
  }
}
