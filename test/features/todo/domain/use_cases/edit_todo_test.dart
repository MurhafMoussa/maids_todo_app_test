import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/edit_todo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late EditTodo useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = EditTodo(mockTodoRepository);
  });

  final editTodoParam = EditTodoParam(
    id: 1,
    isCompleted: true,
  );

  const successMessage = 'Todo updated successfully';

  test('should call edit on the repository and return success message',
      () async {
    // Arrange
    when(mockTodoRepository.edit(any))
        .thenAnswer((_) async => const Right(successMessage));

    // Act
    final result = await useCase(editTodoParam);

    // Assert
    expect(result, const Right(successMessage));
    verify(mockTodoRepository.edit(editTodoParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test('should return unexpected error when repository call fails', () async {
    // Arrange
    when(mockTodoRepository.edit(any))
        .thenAnswer((_) async => const Left(AppExceptions.unexpectedError()));

    // Act
    final result = await useCase(editTodoParam);

    // Assert
    expect(result, const Left(AppExceptions.unexpectedError()));
    verify(mockTodoRepository.edit(editTodoParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });

  test('should return no internet connection error when there is no connection',
      () async {
    // Arrange
    when(mockTodoRepository.edit(any)).thenAnswer(
      (_) async => const Left(AppExceptions.noInternetConnection()),
    );

    // Act
    final result = await useCase(editTodoParam);

    // Assert
    expect(result, const Left(AppExceptions.noInternetConnection()));
    verify(mockTodoRepository.edit(editTodoParam)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
