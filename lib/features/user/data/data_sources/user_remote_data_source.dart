import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/networking/api_consumer.dart';
import 'package:maids_todo_app_test/core/networking/end_points.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/features/user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login(LoginParam body);
  Future<UserModel> refreshToken();
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<UserModel> refreshToken() async {
    final response = await _apiConsumer.post(EndPoints.refreshToken);
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> login(LoginParam body) async {
    final response =
        await _apiConsumer.post(EndPoints.login, body: body.toJson());
    return UserModel.fromJson(response);
  }
}
