import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/networking/api_consumer.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:maids_todo_app_test/features/user/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_remote_data_source_test.mocks.dart';

@GenerateMocks([ApiConsumer])
void main() {
  late UserRemoteDataSourceImpl dataSource;
  late MockApiConsumer mockApiConsumer;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    dataSource = UserRemoteDataSourceImpl(mockApiConsumer);
  });

  group('login', () {
    test('should return UserModel when login is successful', () async {
      // Arrange
      final loginParam = LoginParam(
        username: 'test_user',
        password: 'test_password',
        expirationDateInMinutes: 30,
      );
      final response = {'accessToken': 'test_token', 'id': 1};
      when(mockApiConsumer.post(any, body: anyNamed('body')))
          .thenAnswer((_) async => response);

      // Act
      final result = await dataSource.login(loginParam);

      // Assert
      expect(result, isA<UserModel>());
      expect(result.accessToken, response['accessToken']);
      expect(result.id, response['id']);
    });

    test('should throw an exception when login fails', () {
      // Arrange
      final loginParam = LoginParam(
        username: 'test_user',
        password: 'test_password',
        expirationDateInMinutes: 30,
      );

      when(mockApiConsumer.post(any, body: anyNamed('body')))
          .thenThrow(Exception('Error message'));

      // Act & Assert
      expect(
        () async => await dataSource.login(loginParam),
        throwsA(isA<Exception>()),
      );
    });
  });
}
