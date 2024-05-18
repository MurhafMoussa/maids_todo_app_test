import 'package:maids_todo_app_test/core/params/base_params.dart';

class EditTodoParam extends BaseParams {
  EditTodoParam({
    super.cancelToken,
    required this.isCompleted,
    required this.todo,
  });

  final bool isCompleted;
  final String todo;

  @override
  Map<String, dynamic> toJson() {
    return {
      'completed': isCompleted,
      'todo': todo,
    };
  }
}
