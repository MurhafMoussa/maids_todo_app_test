import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/delete_todo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late DeleteTodo useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = DeleteTodo(mockTodoRepository);
  });

  const idParam = IdParam(1);
  const successMessage = 'Todo deleted successfully';

  test('should call delete on the repository and return success message',
      () async {
    // Arrange
    when(mockTodoRepository.delete(any))
        .thenAnswer((_) async => const Right(successMessage));

    // Act
    final result = await useCase(idParam);

    // Assert
    expect(result, const Right(successMessage));
    verify(mockTodoRepository.delete(idParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test('should return no internet connection error when there is no connection',
      () async {
    // Arrange
    when(mockTodoRepository.delete(any)).thenAnswer(
        (_) async => const Left(AppExceptions.noInternetConnection()),);

    // Act
    final result = await useCase(idParam);

    // Assert
    expect(result, const Left(AppExceptions.noInternetConnection()));
    verify(mockTodoRepository.delete(idParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test('should return default error when an unknown error occurs', () async {
    // Arrange
    const errorMessage = 'An unknown error occurred';
    when(mockTodoRepository.delete(any)).thenAnswer(
        (_) async => const Left(AppExceptions.defaultError(errorMessage)),);

    // Act
    final result = await useCase(idParam);

    // Assert
    expect(result, const Left(AppExceptions.defaultError(errorMessage)));
    verify(mockTodoRepository.delete(idParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
