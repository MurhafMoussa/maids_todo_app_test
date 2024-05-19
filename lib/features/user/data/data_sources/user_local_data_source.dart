import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/features/user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  static const userKey = 'user';
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser();
  UserModel? getUser();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  const UserLocalDataSourceImpl(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  @override
  UserModel? getUser() {
    final userString =
        _sharedPreferences.getString(UserLocalDataSource.userKey);
    if (userString != null) {
      return UserModel.fromJson(jsonDecode(userString));
    }
    return null;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userAsJson = user.toJson();
    _sharedPreferences.setString(
      UserLocalDataSource.userKey,
      jsonEncode(userAsJson),
    );
  }

  @override
  Future<void> deleteUser() async {
    _sharedPreferences.clear();
  }
}
