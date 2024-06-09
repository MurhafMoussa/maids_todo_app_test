import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/features/todo/data/data_sources/todo_local_data_source.dart';
import 'package:maids_todo_app_test/features/todo/data/models/todo_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late TodoLocalDataSourceImpl dataSource;
  late Database database;

  setUp(() async {
    // Initialize FFI (for in-memory database testing)
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    // Create the 'todos' table for testing
    await database.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        todo TEXT,
        completed INTEGER
      )
    ''');

    dataSource = TodoLocalDataSourceImpl(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('TodoLocalDataSourceImpl', () {
    test('should fetch paginated todos', () async {
      // Arrange
      await database.insert('todos', {
        'id': 1,
        'userId': 1,
        'todo': 'Test Todo 1',
        'completed': 0,
      });
      await database.insert('todos', {
        'id': 2,
        'userId': 1,
        'todo': 'Test Todo 2',
        'completed': 1,
      });

      final pageParam = PageParam(skip: 0, pageLength: 1);

      // Act
      final result = await dataSource.getAll(pageParam);

      // Assert
      expect(result.todos.length, 1);
      expect(result.todos.first.id, 1);
      expect(result.total, 2);
    });

    test('should bulk save todos', () async {
      // Arrange
      final todos = [
        const TodoModel(id: 1, userId: 1, todo: 'Test Todo 1', completed: false),
        const TodoModel(id: 2, userId: 1, todo: 'Test Todo 2', completed: true),
      ];

      // Act
      await dataSource.bulkSave(todos);

      // Assert
      final result = await database.query('todos');
      expect(result.length, 2);
      expect(result.first['todo'], 'Test Todo 1');
      expect(result.last['completed'], 1);
    });
  });
}
