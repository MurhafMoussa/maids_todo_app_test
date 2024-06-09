import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/pagination_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';

void main() {
  group('PaginationEntity', () {
    test('should create a PaginationEntity with the given parameters', () {
      // Arrange
      final todos = [
        const TodoEntity(id: 1, userId: 1, todo: 'Todo 1', completed: false),
        const TodoEntity(id: 2, userId: 1, todo: 'Todo 2', completed: true),
      ];
      final paginationEntity = PaginationEntity(
        todos: todos,
        total: 20,
        skip: 0,
        itemCountPerPage: 10,
      );

      // Act & Assert
      expect(paginationEntity.todos, todos);
      expect(paginationEntity.total, 20);
      expect(paginationEntity.skip, 0);
      expect(paginationEntity.itemCountPerPage, 10);
    });

    test('should return true if two PaginationEntity instances are equal', () {
      // Arrange
      final todos1 = [
        const TodoEntity(id: 1, userId: 1, todo: 'Todo 1', completed: false),
        const TodoEntity(id: 2, userId: 1, todo: 'Todo 2', completed: true),
      ];
      final paginationEntity1 = PaginationEntity(
        todos: todos1,
        total: 20,
        skip: 0,
        itemCountPerPage: 10,
      );

      final todos2 = [
        const TodoEntity(id: 1, userId: 1, todo: 'Todo 1', completed: false),
        const TodoEntity(id: 2, userId: 1, todo: 'Todo 2', completed: true),
      ];
      final paginationEntity2 = PaginationEntity(
        todos: todos2,
        total: 20,
        skip: 0,
        itemCountPerPage: 10,
      );

      // Act & Assert
      expect(paginationEntity1, paginationEntity2);
    });

    test('should return false if two PaginationEntity instances are not equal',
        () {
      // Arrange
      final todos1 = [
        const TodoEntity(id: 1, userId: 1, todo: 'Todo 1', completed: false),
        const TodoEntity(id: 2, userId: 1, todo: 'Todo 2', completed: true),
      ];
      final paginationEntity1 = PaginationEntity(
        todos: todos1,
        total: 20,
        skip: 0,
        itemCountPerPage: 10,
      );

      final todos2 = [
        const TodoEntity(id: 3, userId: 2, todo: 'Todo 3', completed: false),
        const TodoEntity(id: 4, userId: 2, todo: 'Todo 4', completed: true),
      ];
      final paginationEntity2 = PaginationEntity(
        todos: todos2,
        total: 30,
        skip: 10,
        itemCountPerPage: 15,
      );

      // Act & Assert
      expect(paginationEntity1 == paginationEntity2, false);
    });
  });
}
