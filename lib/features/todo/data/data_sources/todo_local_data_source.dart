import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/extensions/logger_extension.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/features/todo/data/models/pagination_model.dart';
import 'package:maids_todo_app_test/features/todo/data/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class TodoLocalDataSource {
  Future<PaginationModel> getAll(
    PageParam param,
  );
  Future<void> bulkSave(List<TodoModel> todos);
}

@LazySingleton(as: TodoLocalDataSource)
class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  const TodoLocalDataSourceImpl(this._database);
  final Database _database;

  @override
  Future<PaginationModel> getAll(
    PageParam param,
  ) async {
    final db = _database;
    final offset = (param.skip - 1) * param.pageLength;
    final limit = param.pageLength;

    // Fetch the total count of todos
    final countResult =
        await db.rawQuery('SELECT COUNT(*) as total FROM todos');
    final total = Sqflite.firstIntValue(countResult)!;

    // Fetch the paginated todos
    final maps = await db.query(
      'todos',
      limit: limit,
      offset: offset,
    );

    // Convert maps to List<TodoModel>
    final todos = maps.map((map) {
      return TodoModel(
        id: map['id']! as int,
        completed: (map['completed']! as int) == 1,
        todo: map['todo']! as String,
        userId: map['userId']! as int,
      );
    }).toList();

    total.toString().logI;

    return PaginationModel(
      todos: todos,
      skip: param.skip,
      itemCountPerPage: param.pageLength,
      total: total,
    );
  }

  @override
  Future<void> bulkSave(List<TodoModel> todos) async {
    // final db = _database;
    // final batch = todos
    //     .map(
    //       (todo) => {
    //         'todo': todo.todo,
    //         'id': todo.id,
    //         'completed': todo.completed ? 1 : 0,
    //         'userId': todo.userId,
    //       },
    //     )
    //     .toList();
    // await db.transaction((txn) async {
    //   for (final todoMap in batch) {
    //     final id = todoMap['id'];
    //     if (await _hasId(id! as int)) {
    //       await txn.update(
    //         'todos',
    //         todoMap,
    //         where: 'id = ?',
    //         whereArgs: [id],
    //       );
    //     } else {
    //       await txn.insert('todos', todoMap);
    //     }
    //     await txn.batch().commit();
    //   }
    // });
  }

  Future<bool> _hasId(int id) async {
    final db = _database;
    final results = await db.rawQuery('SELECT 1 FROM todos WHERE id = ?', [id]);
    final count = Sqflite.firstIntValue(results);
    return count != null && count > 0;
  }
}
