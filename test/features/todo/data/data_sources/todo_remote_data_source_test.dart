import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/networking/api_consumer.dart';
import 'package:maids_todo_app_test/core/networking/end_points.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/features/todo/data/data_sources/todo_remote_data_source.dart';
import 'package:maids_todo_app_test/features/todo/data/models/pagination_model.dart';
import 'package:maids_todo_app_test/features/todo/data/models/todo_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todo_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiConsumer])
void main() {
  late TodoRemoteDataSourceImpl dataSource;
  late MockApiConsumer mockApiConsumer;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    dataSource = TodoRemoteDataSourceImpl(mockApiConsumer);
  });

  final addTodoParam =
      AddTodoParam(userId: 1, isCompleted: false, todo: 'Test Todo');
  final editTodoParam = EditTodoParam(isCompleted: true, id: 1);
  const idParam = IdParam(1);
  final pageParam = PageParam(skip: 0, pageLength: 10);

  const todoModel =
      TodoModel(id: 1, userId: 1, todo: 'Test Todo', completed: false);
  const paginationModel = PaginationModel(
    todos: [todoModel],
    total: 1,
    skip: 0,
    itemCountPerPage: 10,
  );

  group('add', () {
    test(
        'should call post on ApiConsumer with correct data and return TodoModel',
        () async {
      // Arrange
      when(mockApiConsumer.post(any, body: anyNamed('body')))
          .thenAnswer((_) async => todoModel.toJson());

      // Act
      final result = await dataSource.add(addTodoParam);

      // Assert
      expect(result, todoModel);
      verify(
        mockApiConsumer.post(
          '${EndPoints.todos}add',
          body: addTodoParam.toJson(),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockApiConsumer);
    });
  });

  group('delete', () {
    test(
        'should call delete on ApiConsumer with correct data and return TodoModel',
        () async {
      // Arrange
      when(mockApiConsumer.delete(any))
          .thenAnswer((_) async => todoModel.toJson());

      // Act
      final result = await dataSource.delete(idParam);

      // Assert
      expect(result, todoModel);
      verify(mockApiConsumer.delete('${EndPoints.todos}${idParam.id}'))
          .called(1);
      verifyNoMoreInteractions(mockApiConsumer);
    });
  });

  group('edit', () {
    test(
        'should call put on ApiConsumer with correct data and return TodoModel',
        () async {
      // Arrange
      when(mockApiConsumer.put(any, body: anyNamed('body')))
          .thenAnswer((_) async => todoModel.toJson());

      // Act
      final result = await dataSource.edit(editTodoParam);

      // Assert
      expect(result, todoModel);
      verify(
        mockApiConsumer.put(
          '${EndPoints.todos}${editTodoParam.id}',
          body: editTodoParam.toJson(),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockApiConsumer);
    });
  });

  group('getAll', () {
    test(
        'should call get on ApiConsumer with correct data and return PaginationModel',
        () async {
      // Arrange
      when(
        mockApiConsumer.get(
          any,
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer((_) async => paginationModel.toJson());

      // Act
      final result = await dataSource.getAll(pageParam);

      // Assert
      expect(result, paginationModel);
      verify(
        mockApiConsumer.get(
          EndPoints.todos,
          queryParameters: pageParam.toJson(),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockApiConsumer);
    });
  });
}
