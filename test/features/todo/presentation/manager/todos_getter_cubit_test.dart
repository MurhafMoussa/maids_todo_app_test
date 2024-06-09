import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_todo_app_test/core/errors/app_exceptions.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/pagination_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/get_all_todos.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todos_getter_cubit.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todos_getter_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todos_getter_cubit_test.mocks.dart';

@GenerateMocks([GetAllTodos])
void main() {
  late TodosGetterCubit cubit;
  late MockGetAllTodos mockGetAllTodos;
  int pageSize = 4;
  setUp(() {
    mockGetAllTodos = MockGetAllTodos();
    cubit = TodosGetterCubit(mockGetAllTodos);
  });

  group('TodosGetterCubit', () {
    test('emits loadInProgress state when the cubit is created', () {
      // Assert
      expect(cubit.state, const TodosGetterState.loadInProgress());
    });

    blocTest<TodosGetterCubit, TodosGetterState>(
      'emits loadFailure state when getAllTodos fails',
      build: () {
        when(mockGetAllTodos(any)).thenAnswer(
          (_) async => const Left(AppExceptions.unexpectedError()),
        );
        return cubit;
      },
      act: (cubit) => cubit.getAllTodos(0),
      expect: () => [
        TodosGetterState.loadFailure(
          AppExceptions.getErrorMessage(
            const AppExceptions.unexpectedError(),
          ),
        ),
      ],
    );

    blocTest<TodosGetterCubit, TodosGetterState>(
      'emits loadSuccess state when getAllTodos is successful and more data can be loaded',
      build: () {
        when(mockGetAllTodos(any)).thenAnswer(
          (_) async => Right(
            PaginationEntity(
              todos: const [
                TodoEntity(id: 1, userId: 1, todo: 'Todo 1', completed: false),
                TodoEntity(id: 2, userId: 1, todo: 'Todo 2', completed: true),
                TodoEntity(id: 3, userId: 1, todo: 'Todo 3', completed: true),
                TodoEntity(id: 4, userId: 1, todo: 'Todo 4', completed: true),
                TodoEntity(id: 5, userId: 1, todo: 'Todo 5', completed: true),
              ],
              total: 20,
              skip: 0,
              itemCountPerPage: pageSize,
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.getAllTodos(0, pageSize: pageSize),
      expect: () => [
        const TodosGetterState.loadSuccess(
          [
            TodoEntity(id: 1, userId: 1, todo: 'Todo 1', completed: false),
            TodoEntity(id: 2, userId: 1, todo: 'Todo 2', completed: true),
            TodoEntity(id: 3, userId: 1, todo: 'Todo 3', completed: true),
            TodoEntity(id: 4, userId: 1, todo: 'Todo 4', completed: true),
            TodoEntity(id: 5, userId: 1, todo: 'Todo 5', completed: true),
          ],
          false,
        ),
      ],
    );

    blocTest<TodosGetterCubit, TodosGetterState>(
      'emits loadSuccess state when getAllTodos is successful and no more data can be loaded',
      build: () {
        when(mockGetAllTodos(any)).thenAnswer(
          (_) async => Right(
            PaginationEntity(
              todos: const [
                TodoEntity(id: 1, userId: 1, todo: 'Todo 1', completed: false),
                TodoEntity(id: 2, userId: 1, todo: 'Todo 2', completed: true),
              ],
              total: 20,
              skip: 0,
              itemCountPerPage: pageSize,
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.getAllTodos(0, pageSize: pageSize),
      expect: () => [
        const TodosGetterState.loadSuccess(
          [
            TodoEntity(id: 1, userId: 1, todo: 'Todo 1', completed: false),
            TodoEntity(id: 2, userId: 1, todo: 'Todo 2', completed: true),
          ],
          true,
        ),
      ],
    );
  });
}
