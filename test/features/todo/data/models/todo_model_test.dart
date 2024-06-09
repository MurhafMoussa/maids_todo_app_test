import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/features/todo/data/models/todo_model.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';

void main() {
  const todoModel = TodoModel(
    id: 1,
    userId: 1,
    todo: 'Test Todo',
    completed: false,
  );

  const todoJson = {
    'id': 1,
    'userId': 1,
    'todo': 'Test Todo',
    'completed': false,
  };

  group('TodoModel', () {
    test('should correctly convert from JSON', () {
      final result = TodoModel.fromJson(todoJson);
      expect(result, todoModel);
    });

    test('should correctly convert to JSON', () {
      final result = todoModel.toJson();
      expect(result, todoJson);
    });

    test('should correctly convert to TodoEntity', () {
      final result = todoModel.toEntity();
      const expectedEntity = TodoEntity(
        id: 1,
        userId: 1,
        todo: 'Test Todo',
        completed: false,
      );
      expect(result, expectedEntity);
    });
  });
}
