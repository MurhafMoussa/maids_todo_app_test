import 'package:dartz/dartz.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/errors/exception_handler.dart';
import 'package:maids_todo_app_test/core/networking/connectivity.dart';
import 'package:maids_todo_app_test/core/params/login_param.dart';
import 'package:maids_todo_app_test/features/user/data/data_sources/user_local_data_source.dart';
import 'package:maids_todo_app_test/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:maids_todo_app_test/features/user/domain/repositories/user_facade.dart';

class UserFacadeImpl implements UserFacade {
  UserFacadeImpl(
    this._userLocalDataSource,
    this._userRemoteDataSource,
    this._connectivity,
  );

  final UserLocalDataSource _userLocalDataSource;
  final UserRemoteDataSource _userRemoteDataSource;
  final Connectivity _connectivity;
  @override
  Future<Either<AppExceptions, String>> login(LoginParam body) async {
    if (!await _connectivity.isConnected) {
      return const Left(AppExceptions.noInternetConnection());
    }
    return handleRepositoryCalls<String>(
      () async {
        final response = await _userRemoteDataSource.login(body);
        _userLocalDataSource.saveUser(response);
        return 'Logged in successfully';
      },
    );
  }

  @override
  Future<Either<AppExceptions, Unit>> refreshToken() async {
    if (!await _connectivity.isConnected) {
      return const Left(AppExceptions.noInternetConnection());
    }
    return handleRepositoryCalls<Unit>(
      () async {
        final response = await _userRemoteDataSource.refreshToken();
        _userLocalDataSource.saveUser(response);
        return unit;
      },
    );
  }
}
