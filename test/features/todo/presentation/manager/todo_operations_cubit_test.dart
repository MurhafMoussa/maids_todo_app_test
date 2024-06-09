import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/add_todo.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/delete_todo.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/edit_todo.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todo_operations_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todo_operations_cubit_test.mocks.dart';

@GenerateMocks([AddTodo, EditTodo, DeleteTodo])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TodoOperationsCubit cubit;
  late MockAddTodo mockAddTodo;
  late MockEditTodo mockEditTodo;
  late MockDeleteTodo mockDeleteTodo;

  setUp(() {
    mockAddTodo = MockAddTodo();
    mockEditTodo = MockEditTodo();
    mockDeleteTodo = MockDeleteTodo();
    cubit = TodoOperationsCubit(mockAddTodo, mockEditTodo, mockDeleteTodo);
  });

  group('TodoOperationsCubit', () {
    final addTodoParam =
        AddTodoParam(userId: 1, isCompleted: false, todo: 'Test Todo');
    final editTodoParam = EditTodoParam(isCompleted: true, id: 1);
    const idParam = IdParam(1);

    blocTest<TodoOperationsCubit, StandardState<String>>(
      'emits [loading, success] when add is called and succeeds',
      build: () {
        when(mockAddTodo.call(any))
            .thenAnswer((_) async => const Right('Todo added successfully'));
        return cubit;
      },
      act: (cubit) => cubit.add(addTodoParam),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState<String>.success('Todo added successfully'),
      ],
      verify: (cubit) {
        verify(mockAddTodo.call(addTodoParam)).called(1);
      },
    );

    blocTest<TodoOperationsCubit, StandardState<String>>(
      'emits [loading, failure] when add is called and fails',
      build: () {
        when(mockAddTodo.call(any)).thenAnswer(
            (_) async => const Left(AppExceptions.unexpectedError()),);
        return cubit;
      },
      act: (cubit) => cubit.add(addTodoParam),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState<String>.failure(AppExceptions.unexpectedError()),
      ],
      verify: (cubit) {
        verify(mockAddTodo.call(addTodoParam)).called(1);
      },
    );

    blocTest<TodoOperationsCubit, StandardState<String>>(
      'emits [loading, success] when edit is called and succeeds',
      build: () {
        when(mockEditTodo.call(any))
            .thenAnswer((_) async => const Right('Todo updated successfully'));
        return cubit;
      },
      act: (cubit) => cubit.edit(editTodoParam),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState<String>.success('Todo updated successfully'),
      ],
      verify: (cubit) {
        verify(mockEditTodo.call(editTodoParam)).called(1);
      },
    );

    blocTest<TodoOperationsCubit, StandardState<String>>(
      'emits [loading, failure] when edit is called and fails',
      build: () {
        when(mockEditTodo.call(any)).thenAnswer(
            (_) async => const Left(AppExceptions.unexpectedError()),);
        return cubit;
      },
      act: (cubit) => cubit.edit(editTodoParam),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState<String>.failure(AppExceptions.unexpectedError()),
      ],
      verify: (cubit) {
        verify(mockEditTodo.call(editTodoParam)).called(1);
      },
    );

    blocTest<TodoOperationsCubit, StandardState<String>>(
      'emits [loading, success] when delete is called and succeeds',
      build: () {
        when(mockDeleteTodo.call(any))
            .thenAnswer((_) async => const Right('Todo deleted successfully'));
        return cubit;
      },
      act: (cubit) => cubit.delete(idParam),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState<String>.success('Todo deleted successfully'),
      ],
      verify: (cubit) {
        verify(mockDeleteTodo.call(idParam)).called(1);
      },
    );

    blocTest<TodoOperationsCubit, StandardState<String>>(
      'emits [loading, failure] when delete is called and fails',
      build: () {
        when(mockDeleteTodo.call(any)).thenAnswer(
            (_) async => const Left(AppExceptions.unexpectedError()),);
        return cubit;
      },
      act: (cubit) => cubit.delete(idParam),
      expect: () => [
        const StandardState<String>.loading(),
        const StandardState<String>.failure(AppExceptions.unexpectedError()),
      ],
      verify: (cubit) {
        verify(mockDeleteTodo.call(idParam)).called(1);
      },
    );
  });
}
