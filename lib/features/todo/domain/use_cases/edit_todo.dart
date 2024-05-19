import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/usecases/usecase.dart';
import 'package:maids_todo_app_test/features/todo/domain/repositories/todo_repository.dart';

@lazySingleton
class EditTodo extends UseCase<String, EditTodoParam> {
  const EditTodo(this._todoRepository);

  final TodoRepository _todoRepository;
  @override
  Future<Either<AppExceptions, String>> call(EditTodoParam params) async {
    return await _todoRepository.edit(params);
  }
}
