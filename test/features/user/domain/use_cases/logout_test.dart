import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/no_params.dart';
import 'package:maids_todo_app_test/features/user/domain/repositories/user_facade.dart';
import 'package:maids_todo_app_test/features/user/domain/use_cases/logout.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_test.mocks.dart';

@GenerateMocks([UserFacade])
void main() {
  late Logout useCase;
  late MockUserFacade mockUserFacade;

  setUp(() {
    mockUserFacade = MockUserFacade();
    useCase = Logout(mockUserFacade);
  });

  const successMessage = 'Logged out successfully';

  test('should call logout on the repository and return success message',
      () async {
    // Arrange
    when(mockUserFacade.logout())
        .thenAnswer((_) async => const Right(successMessage));

    // Act
    final result = await useCase(const NoParams());

    // Assert
    expect(result, const Right(successMessage));
    verify(mockUserFacade.logout()).called(1);
    verifyNoMoreInteractions(mockUserFacade);
  });

  test('should return unexpected error when repository call fails', () async {
    // Arrange
    when(mockUserFacade.logout())
        .thenAnswer((_) async => const Left(AppExceptions.unexpectedError()));

    // Act
    final result = await useCase(const NoParams());

    // Assert
    expect(result, const Left(AppExceptions.unexpectedError()));
    verify(mockUserFacade.logout()).called(1);
    verifyNoMoreInteractions(mockUserFacade);
  });

  test('should return no internet connection error when there is no connection',
      () async {
    // Arrange
    when(mockUserFacade.logout()).thenAnswer(
      (_) async => const Left(AppExceptions.noInternetConnection()),
    );

    // Act
    final result = await useCase(const NoParams());

    // Assert
    expect(result, const Left(AppExceptions.noInternetConnection()));
    verify(mockUserFacade.logout()).called(1);
    verifyNoMoreInteractions(mockUserFacade);
  });
}
