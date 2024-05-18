import 'package:maids_todo_app_test/core/entities/base_entity.dart';

class TodoEntity extends BaseEntity {
  const TodoEntity({
    required this.todoId,
    required this.userId,
    required this.todo,
    required this.isCompleted,
  });

  final int todoId;
  final int userId;
  final String todo;
  final bool isCompleted;

  @override
  List<Object> get props => [todoId, userId, todo, isCompleted];
}
