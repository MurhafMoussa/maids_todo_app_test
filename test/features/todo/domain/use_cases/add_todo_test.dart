import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/add_todo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late AddTodo useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = AddTodo(mockTodoRepository);
  });

  final addTodoParam = AddTodoParam(
    userId: 1,
    isCompleted: false,
    todo: 'Test Todo',
  );

  const successMessage = 'Todo added successfully';

  test('should call add on the repository and return success message',
      () async {
    // Arrange
    when(mockTodoRepository.add(any))
        .thenAnswer((_) async => const Right(successMessage));

    // Act
    final result = await useCase(addTodoParam);

    // Assert
    expect(result, const Right(successMessage));
    verify(mockTodoRepository.add(addTodoParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test('should return unexpected error when repository call fails', () async {
    // Arrange
    const errorMessage = 'Unexpected error occurred';
    when(mockTodoRepository.add(any))
        .thenAnswer((_) async => const Left(AppExceptions.unexpectedError()));

    // Act
    final result = await useCase(addTodoParam);

    // Assert
    expect(result, const Left(AppExceptions.unexpectedError()));
    verify(mockTodoRepository.add(addTodoParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test('should return no internet connection error when there is no connection',
      () async {
    // Arrange
    when(mockTodoRepository.add(any)).thenAnswer(
        (_) async => const Left(AppExceptions.noInternetConnection()),);

    // Act
    final result = await useCase(addTodoParam);

    // Assert
    expect(result, const Left(AppExceptions.noInternetConnection()));
    verify(mockTodoRepository.add(addTodoParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
