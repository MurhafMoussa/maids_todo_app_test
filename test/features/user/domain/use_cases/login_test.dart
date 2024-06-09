import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/features/user/domain/repositories/user_facade.dart';
import 'package:maids_todo_app_test/features/user/domain/use_cases/login.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

@GenerateMocks([UserFacade])
void main() {
  late Login useCase;
  late MockUserFacade mockUserFacade;

  setUp(() {
    mockUserFacade = MockUserFacade();
    useCase = Login(mockUserFacade);
  });

  final loginParam = LoginParam(
    username: 'test_user',
    password: 'test_password',
    expirationDateInMinutes: 30,
  );

  const successMessage = 'Logged in successfully';

  test('should call login on the repository and return success message',
      () async {
    // Arrange
    when(mockUserFacade.login(any))
        .thenAnswer((_) async => const Right(successMessage));

    // Act
    final result = await useCase(loginParam);

    // Assert
    expect(result, const Right(successMessage));
    verify(mockUserFacade.login(loginParam)).called(1);
    verifyNoMoreInteractions(mockUserFacade);
  });

  test('should return unexpected error when repository call fails', () async {
    // Arrange
    when(mockUserFacade.login(any))
        .thenAnswer((_) async => const Left(AppExceptions.unexpectedError()));

    // Act
    final result = await useCase(loginParam);

    // Assert
    expect(result, const Left(AppExceptions.unexpectedError()));
    verify(mockUserFacade.login(loginParam)).called(1);
    verifyNoMoreInteractions(mockUserFacade);
  });

  test('should return no internet connection error when there is no connection',
      () async {
    // Arrange
    when(mockUserFacade.login(any)).thenAnswer(
      (_) async => const Left(AppExceptions.noInternetConnection()),
    );

    // Act
    final result = await useCase(loginParam);

    // Assert
    expect(result, const Left(AppExceptions.noInternetConnection()));
    verify(mockUserFacade.login(loginParam)).called(1);
    verifyNoMoreInteractions(mockUserFacade);
  });
}
