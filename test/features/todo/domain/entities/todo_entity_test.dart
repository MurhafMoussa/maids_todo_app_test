import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';

void main() {
  group('TodoEntity', () {
    test('should create a TodoEntity with the given parameters', () {
      // Arrange
      const todoEntity = TodoEntity(
        id: 1,
        userId: 1,
        todo: 'Test todo',
        completed: false,
      );

      // Act & Assert
      expect(todoEntity.id, 1);
      expect(todoEntity.userId, 1);
      expect(todoEntity.todo, 'Test todo');
      expect(todoEntity.completed, false);
    });

    test('should return true if two TodoEntity instances are equal', () {
      // Arrange
      const todoEntity1 = TodoEntity(
        id: 1,
        userId: 1,
        todo: 'Test todo',
        completed: false,
      );

      const todoEntity2 = TodoEntity(
        id: 1,
        userId: 1,
        todo: 'Test todo',
        completed: false,
      );

      // Act & Assert
      expect(todoEntity1, todoEntity2);
    });

    test('should return false if two TodoEntity instances are not equal', () {
      // Arrange
      const todoEntity1 = TodoEntity(
        id: 1,
        userId: 1,
        todo: 'Test todo',
        completed: false,
      );

      const todoEntity2 = TodoEntity(
        id: 2,
        userId: 2,
        todo: 'Another todo',
        completed: true,
      );

      // Act & Assert
      expect(todoEntity1 == todoEntity2, false);
    });
  });
}
