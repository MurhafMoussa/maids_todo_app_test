import 'package:injectable/injectable.dart';
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
  TodoLocalDataSourceImpl(this._database);
  final Database _database;
  bool firstFetch = true;
  late int total;
  @override
  Future<PaginationModel> getAll(
    PageParam param,
  ) async {
    final db = _database;
    final offset = param.skip;
    final limit = param.pageLength;

    // Fetch the total count of todos
    await _getTotal(db);

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

    return PaginationModel(
      todos: todos,
      skip: param.skip,
      itemCountPerPage: param.pageLength,
      total: total,
    );
  }

  Future<void> _getTotal(Database db) async {
    if (firstFetch) {
      final countResult =
          await db.rawQuery('SELECT COUNT(*) as total FROM todos');
      total = Sqflite.firstIntValue(countResult)!;
      firstFetch = false;
    }
  }

  @override
  Future<void> bulkSave(List<TodoModel> todos) async {
    final db = _database;

    Batch batch = db.batch();
    for (final todo in todos) {
      batch.insert(
        'todos',
        todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }
}
