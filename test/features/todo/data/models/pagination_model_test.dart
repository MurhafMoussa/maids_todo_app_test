import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/features/todo/data/models/pagination_model.dart';
import 'package:maids_todo_app_test/features/todo/data/models/todo_model.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/pagination_entity.dart';

void main() {
  group('PaginationModel', () {
    final todoJson = {
      'id': 1,
      'userId': 1,
      'completed': false,
      'todo': 'Test Todo',
    };

    final paginationJson = {
      'todos': [todoJson],
      'total': 1,
      'skip': 0,
      'limit': 10,
    };

    const todoModel = TodoModel(
      id: 1,
      userId: 1,
      completed: false,
      todo: 'Test Todo',
    );

    const paginationModel = PaginationModel(
      todos: [todoModel],
      total: 1,
      skip: 0,
      itemCountPerPage: 10,
    );

    test('fromJson should return a valid model', () {
      // act
      final result = PaginationModel.fromJson(paginationJson);

      // assert
      expect(result, paginationModel);
    });

    test('toJson should return a valid JSON map', () {
      // act
      final result = paginationModel.toJson();

      // assert
      expect(result, paginationJson);
    });

    test('toEntity should return a valid entity', () {
      // arrange
      final expectedEntity = PaginationEntity(
        todos: [todoModel.toEntity()],
        total: 1,
        skip: 0,
        itemCountPerPage: 10,
      );

      // act
      final result = paginationModel.toEntity();

      // assert
      expect(result, expectedEntity);
    });
  });
}
