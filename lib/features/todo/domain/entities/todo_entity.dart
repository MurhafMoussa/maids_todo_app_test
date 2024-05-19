import 'package:maids_todo_app_test/core/entities/base_entity.dart';

class TodoEntity extends BaseEntity {
  const TodoEntity({
    required this.id,
    required this.userId,
    required this.todo,
    required this.completed,
  });

  final int id;
  final int userId;
  final String todo;
  final bool completed;

  @override
  List<Object> get props => [id, userId, todo, completed];
}
