import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/entities/no_entity.dart';
import 'package:maids_todo_app_test/features/user/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('fromJson should return a valid UserModel instance', () {
      // Arrange
      final jsonData = {
        'accessToken': 'sample_token',
        'id': 123,
      };

      // Act
      final userModel = UserModel.fromJson(jsonData);

      // Assert
      expect(userModel, isA<UserModel>());
      expect(userModel.accessToken, 'sample_token');
      expect(userModel.id, 123);
    });

    test('toJson should return a valid JSON representation', () {
      // Arrange
      const userModel = UserModel(accessToken: 'sample_accessToken', id: 123);

      // Act
      final json = userModel.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json['accessToken'], 'sample_accessToken');
      expect(json['id'], 123);
    });

    test('toEntity should return a NoEntity instance', () {
      // Arrange
      const userModel = UserModel(accessToken: 'sample_accessToken', id: 123);

      // Act
      final entity = userModel.toEntity();

      // Assert
      expect(entity, isA<NoEntity>());
    });
  });
}
