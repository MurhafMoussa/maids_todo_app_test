import 'package:maids_todo_app_test/core/params/base_params.dart';

class AddTodoParam extends BaseParams {
  AddTodoParam(
      {super.cancelToken,
      required this.userId,
      required this.isCompleted,
      required this.todo,});

  final int userId;
  final bool isCompleted;
  final String todo;

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'completed': isCompleted,
      'todo': todo,
    };
  }
}
