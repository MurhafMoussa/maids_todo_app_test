import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/networking/connectivity.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/features/user/data/data_sources/user_local_data_source.dart';
import 'package:maids_todo_app_test/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:maids_todo_app_test/features/user/data/models/user_model.dart';
import 'package:maids_todo_app_test/features/user/data/repositories/user_facade_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_facade_impl.mocks.dart';

@GenerateMocks([UserLocalDataSource, UserRemoteDataSource, Connectivity])
void main() {
  late UserFacadeImpl userFacade;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockConnectivity = MockConnectivity();
    userFacade = UserFacadeImpl(
      mockUserLocalDataSource,
      mockUserRemoteDataSource,
      mockConnectivity,
    );
  });

  group('login', () {
    test('should return "Logged in successfully" when login is successful',
        () async {
      // Arrange
      final loginParam = LoginParam(
        username: 'test_user',
        password: 'test_password',
        expirationDateInMinutes: 30,
      );
      when(mockConnectivity.isConnected).thenAnswer((_) async => true);
      when(mockUserRemoteDataSource.login(loginParam))
          .thenAnswer((_) async => const UserModel(token: 'test_token', id: 1));
      when(mockUserLocalDataSource.saveUser(any)).thenAnswer((_) async => true);

      // Act
      final result = await userFacade.login(loginParam);

      // Assert
      expect(result, isA<Right<AppExceptions, String>>());
      expect(result.getOrElse(() => ''), 'Logged in successfully');
      verify(mockUserRemoteDataSource.login(loginParam)).called(1);
      verify(mockUserLocalDataSource.saveUser(any)).called(1);
    });

    test(
        'should return AppExceptions.noInternetConnection() when no internet connection',
        () async {
      // Arrange
      final loginParam = LoginParam(
        username: 'test_user',
        password: 'test_password',
        expirationDateInMinutes: 30,
      );
      when(mockConnectivity.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await userFacade.login(loginParam);

      // Assert
      expect(result, const Left(AppExceptions.noInternetConnection()));
      verifyNever(mockUserRemoteDataSource.login(loginParam));
      verifyNever(mockUserLocalDataSource.saveUser(any));
    });
  });

  group('logout', () {
    test('should return "Logged out successfully"', () async {
      // Arrange
      when(mockUserLocalDataSource.deleteUser()).thenAnswer((_) async => true);

      // Act
      final result = await userFacade.logout();

      // Assert
      expect(result, isA<Right<AppExceptions, String>>());
      expect(result.getOrElse(() => ''), 'Logged out successfully');
      verify(mockUserLocalDataSource.deleteUser()).called(1);
    });
  });
}
