import 'package:maids_todo_app_test/core/entities/base_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';

class PaginationEntity extends BaseEntity {
  const PaginationEntity({
    required this.todos,
    required this.total,
    required this.skip,
    required this.itemCountPerPage,
  });

  final List<TodoEntity> todos;
  final int total;
  final int skip;
  final int itemCountPerPage;

  @override
  List<Object> get props => [todos, total, skip, itemCountPerPage];
}
