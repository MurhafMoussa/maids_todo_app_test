import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/core/typedefs/result.dart';
import 'package:maids_todo_app_test/core/usecases/usecase.dart';
import 'package:maids_todo_app_test/features/todo/domain/repositories/todo_repository.dart';

@lazySingleton
class DeleteTodo extends UseCase<String, IdParam> {
  const DeleteTodo(this._todoRepository);

  final TodoRepository _todoRepository;
  @override
  Future<Result<String>> call(IdParam param) async {
    return await _todoRepository.delete(param);
  }
}
