import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/features/user/domain/use_cases/login.dart';
import 'package:maids_todo_app_test/features/user/domain/use_cases/logout.dart';
import 'package:maids_todo_app_test/features/user/presentation/manager/user_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_cubit_test.mocks.dart';

@GenerateMocks([Login, Logout])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late UserCubit cubit;
  late MockLogin mockLogin;
  late MockLogout mockLogout;

  setUp(() {
    mockLogin = MockLogin();
    mockLogout = MockLogout();
    cubit = UserCubit(mockLogin, mockLogout);
  });

  group('UserCubit', () {
    blocTest<UserCubit, StandardState<String>>(
      'emits loading and success states when login is successful',
      build: () {
        when(mockLogin(any))
            .thenAnswer((_) async => const Right('Logged in successfully'));
        return cubit;
      },
      act: (cubit) => cubit.login(),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState.success('Logged in successfully'),
      ],
    );

    blocTest<UserCubit, StandardState<String>>(
      'emits loading and failure states when login fails',
      build: () {
        when(mockLogin(any)).thenAnswer(
            (_) async => const Left(AppExceptions.unexpectedError()),);
        return cubit;
      },
      act: (cubit) => cubit.login(),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState<String>.failure(AppExceptions.unexpectedError()),
      ],
    );

    blocTest<UserCubit, StandardState<String>>(
      'emits loading and success states when logout is successful',
      build: () {
        when(mockLogout(any))
            .thenAnswer((_) async => const Right('Logged out successfully'));
        return cubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState.success('Logged out successfully'),
      ],
    );

    blocTest<UserCubit, StandardState<String>>(
      'emits loading and failure states when logout fails',
      build: () {
        when(mockLogout(any)).thenAnswer(
            (_) async => const Left(AppExceptions.unexpectedError()),);
        return cubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState<String>.failure(AppExceptions.unexpectedError()),
      ],
    );
  });
}
