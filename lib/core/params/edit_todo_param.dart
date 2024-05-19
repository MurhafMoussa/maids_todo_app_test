import 'package:maids_todo_app_test/core/params/base_params.dart';

class EditTodoParam extends BaseParams {
  EditTodoParam({
    super.cancelToken,
    required this.isCompleted,
    required this.id,
  });

  final bool isCompleted;
  final int id;

  @override
  Map<String, dynamic> toJson() {
    return {
      'completed': isCompleted,
    };
  }
}
