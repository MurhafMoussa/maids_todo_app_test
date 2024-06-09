import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/networking/connectivity.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/features/todo/data/data_sources/todo_local_data_source.dart';
import 'package:maids_todo_app_test/features/todo/data/data_sources/todo_remote_data_source.dart';
import 'package:maids_todo_app_test/features/todo/data/models/pagination_model.dart';
import 'package:maids_todo_app_test/features/todo/data/models/todo_model.dart';
import 'package:maids_todo_app_test/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todo_repository_impl_test.mocks.dart';

@GenerateMocks([TodoRemoteDataSource, TodoLocalDataSource, Connectivity])
void main() {
  late TodoRepositoryImpl repository;
  late MockTodoRemoteDataSource mockRemoteDataSource;
  late MockTodoLocalDataSource mockLocalDataSource;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockRemoteDataSource = MockTodoRemoteDataSource();
    mockLocalDataSource = MockTodoLocalDataSource();
    mockConnectivity = MockConnectivity();
    repository = TodoRepositoryImpl(
      mockRemoteDataSource,
      mockConnectivity,
      mockLocalDataSource,
    );
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
    test('should return no internet connection when not connected', () async {
      // Arrange
      when(mockConnectivity.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.add(addTodoParam);

      // Assert
      expect(result, const Left(AppExceptions.noInternetConnection()));
      verify(mockConnectivity.isConnected).called(1);
      verifyNoMoreInteractions(mockConnectivity);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('should return success message when connected and add succeeds',
        () async {
      // Arrange
      when(mockConnectivity.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.add(any)).thenAnswer((_) async => todoModel);

      // Act
      final result = await repository.add(addTodoParam);

      // Assert
      expect(result, const Right('Todo added successfully'));
      verify(mockConnectivity.isConnected).called(1);
      verify(mockRemoteDataSource.add(addTodoParam)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('delete', () {
    test('should return no internet connection when not connected', () async {
      // Arrange
      when(mockConnectivity.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.delete(idParam);

      // Assert
      expect(result, const Left(AppExceptions.noInternetConnection()));
      verify(mockConnectivity.isConnected).called(1);
      verifyNoMoreInteractions(mockConnectivity);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('should return success message when connected and delete succeeds',
        () async {
      // Arrange
      when(mockConnectivity.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.delete(any)).thenAnswer((_) async => todoModel);

      // Act
      final result = await repository.delete(idParam);

      // Assert
      expect(result, const Right('Todo deleted successfully'));
      verify(mockConnectivity.isConnected).called(1);
      verify(mockRemoteDataSource.delete(idParam)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('edit', () {
    test('should return no internet connection when not connected', () async {
      // Arrange
      when(mockConnectivity.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.edit(editTodoParam);

      // Assert
      expect(result, const Left(AppExceptions.noInternetConnection()));
      verify(mockConnectivity.isConnected).called(1);
      verifyNoMoreInteractions(mockConnectivity);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('should return success message when connected and edit succeeds',
        () async {
      // Arrange
      when(mockConnectivity.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.edit(any)).thenAnswer((_) async => todoModel);

      // Act
      final result = await repository.edit(editTodoParam);

      // Assert
      expect(result, const Right('Todo updated successfully'));
      verify(mockConnectivity.isConnected).called(1);
      verify(mockRemoteDataSource.edit(editTodoParam)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('getAll', () {
    test('should return local data when not connected', () async {
      // Arrange
      when(mockConnectivity.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getAll(any))
          .thenAnswer((_) async => paginationModel);

      // Act
      final result = await repository.getAll(pageParam);

      // Assert
      expect(result, Right(paginationModel.toEntity()));
      verify(mockConnectivity.isConnected).called(1);
      verify(mockLocalDataSource.getAll(pageParam)).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return remote data when connected', () async {
      // Arrange
      when(mockConnectivity.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAll(any))
          .thenAnswer((_) async => paginationModel);

      // Act
      final result = await repository.getAll(pageParam);

      // Assert
      expect(result, Right(paginationModel.toEntity()));
      verify(mockConnectivity.isConnected).called(1);
      verify(mockRemoteDataSource.getAll(pageParam)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
