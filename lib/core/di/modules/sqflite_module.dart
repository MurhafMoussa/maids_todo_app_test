import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class SqfliteModuleModule {
  @preResolve
  Future<Database> get sqfLite async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/todos.db';

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos (
            id INTEGER NOT NULL,
            todo TEXT NOT NULL,
            completed INTEGER NOT NULL,
            userId INTEGER NOT NULL
          )
        ''');
      },
    );
    return database;
  }
}
