import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maids_todo_app_test/core/params/add_todo_param.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/core/states/standard_state.dart';
import 'package:maids_todo_app_test/core/typedefs/result.dart';
import 'package:maids_todo_app_test/core/ui/widgets/forms/text_area_form_field/text_area_form_field_controller.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/add_todo.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/delete_todo.dart';
import 'package:maids_todo_app_test/features/todo/domain/use_cases/edit_todo.dart';

@injectable
class TodoOperationsCubit extends Cubit<StandardState<String>> {
  TodoOperationsCubit(this._addTodo, this._editTodo, this._deleteTodo)
      : super(const StandardState.initial()) {
    textAreaController = TextAreaFormFieldController(
      onChange: (String value) {
        todoDescription = value;
      },
      hint: 'enter your todo description here',
      isFieldRequired: true,
    );
  }
  final AddTodo _addTodo;
  final EditTodo _editTodo;
  final DeleteTodo _deleteTodo;
  late final TextAreaFormFieldController textAreaController;
  String todoDescription = '';
  Future<void> add(AddTodoParam param) async {
    await _doOperation(
      () => _addTodo(param),
    );
  }

  Future<void> edit(EditTodoParam param) async => await _doOperation(
        () => _editTodo(param),
      );

  Future<void> delete(IdParam param) async => await _doOperation(
        () => _deleteTodo(param),
      );

  Future<void> _doOperation(Future<Result<String>> Function() function) async {
    emit(const StandardState.loading());
    final response = await function();
    response.fold(
      (exception) => emit(
        StandardState.failure(exception),
      ),
      (message) => emit(
        StandardState.success(message),
      ),
    );
  }

  @override
  Future<void> close() {
    textAreaController.onClose();
    return super.close();
  }
}
