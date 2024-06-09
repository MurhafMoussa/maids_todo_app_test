import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/page_param.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/pagination_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/get_all_todos.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_todos_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late GetAllTodos useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = GetAllTodos(mockTodoRepository);
  });

  final pageParam = PageParam(skip: 0, pageLength: 10);
  final todoList = [
    const TodoEntity(id: 1, userId: 1, todo: 'Test Todo 1', completed: false),
    const TodoEntity(id: 2, userId: 1, todo: 'Test Todo 2', completed: true),
  ];

  final paginationEntity = PaginationEntity(
    todos: todoList,
    total: 2,
    skip: 0,
    itemCountPerPage: 10,
  );

  test('should call getAll on the repository and return PaginationEntity',
      () async {
    // Arrange
    when(mockTodoRepository.getAll(any))
        .thenAnswer((_) async => Right(paginationEntity));

    // Act
    final result = await useCase(pageParam);

    // Assert
    expect(result, Right(paginationEntity));
    verify(mockTodoRepository.getAll(pageParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test('should return unexpected error when repository call fails', () async {
    // Arrange
    const error = AppExceptions.unexpectedError();
    when(mockTodoRepository.getAll(any))
        .thenAnswer((_) async => const Left(error));

    // Act
    final result = await useCase(pageParam);

    // Assert
    expect(result, const Left(error));
    verify(mockTodoRepository.getAll(pageParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test('should return no internet connection error when there is no connection',
      () async {
    // Arrange
    const error = AppExceptions.noInternetConnection();
    when(mockTodoRepository.getAll(any))
        .thenAnswer((_) async => const Left(error));

    // Act
    final result = await useCase(pageParam);

    // Assert
    expect(result, const Left(error));
    verify(mockTodoRepository.getAll(pageParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
