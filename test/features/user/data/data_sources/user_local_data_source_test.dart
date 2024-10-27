import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/features/user/data/data_sources/user_local_data_source.dart';
import 'package:maids_todo_app_test/features/user/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('UserLocalDataSourceImpl', () {
    late MockSharedPreferences mockSharedPreferences;
    late UserLocalDataSourceImpl dataSource;
    const user = UserModel(id: 1, accessToken: 'some_token');
    final encodedUser = jsonEncode(user.toJson());

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.getString(UserLocalDataSource.userKey))
          .thenReturn(encodedUser);
      dataSource = UserLocalDataSourceImpl(mockSharedPreferences);
    });

    test('gets saved user successfully', () async {
      final retrievedUser = dataSource.getUser();

      expect(retrievedUser, user);
      verify(mockSharedPreferences.getString(UserLocalDataSource.userKey));
    });

    test('gets null for no saved user', () async {
      when(mockSharedPreferences.getString(UserLocalDataSource.userKey))
          .thenReturn(null);

      final retrievedUser = dataSource.getUser();

      expect(retrievedUser, null);
      verify(mockSharedPreferences.getString(UserLocalDataSource.userKey));
    });

    test('saves user to SharedPreferences', () async {
      when(
        mockSharedPreferences.setString(
          'user',
          '{"accessToken":"some_token","id":1}',
        ),
      ).thenAnswer((_) => Future.value(true));
      await dataSource.saveUser(user);
      final userAsJson = jsonEncode(user.toJson());
      verify(
        mockSharedPreferences.setString(
          UserLocalDataSource.userKey,
          userAsJson,
        ),
      );
    });

    test('clears SharedPreferences on user deletion', () async {
      when(mockSharedPreferences.clear()).thenAnswer((_) => Future.value(true));
      await dataSource.deleteUser();

      verify(mockSharedPreferences.clear());
    });
  });
}
