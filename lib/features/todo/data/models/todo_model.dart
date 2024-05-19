import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maids_todo_app_test/core/networking/base_model.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel extends BaseModel<TodoEntity> with _$TodoModel {
  const factory TodoModel({
    required int id,
    required int userId,
    required String todo,
    required bool completed,
  }) = _TodoModel;
  const TodoModel._();

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  @override
  TodoEntity toEntity() => TodoEntity(
        id: id,
        userId: userId,
        todo: todo,
        completed: completed,
      );
}
