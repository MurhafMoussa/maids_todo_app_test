import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:maids_todo_app_test/core/constants/padding_manager.dart';
import 'package:maids_todo_app_test/core/params/edit_todo_param.dart';
import 'package:maids_todo_app_test/core/params/id_param.dart';
import 'package:maids_todo_app_test/features/todo/domain/entities/todo_entity.dart';
import 'package:maids_todo_app_test/features/todo/presentation/manager/todo_operations_cubit.dart';

class Todo extends StatefulWidget {
  const Todo({
    super.key,
    required this.todo,
  });

  final TodoEntity todo;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  late bool completed;
  @override
  void initState() {
    super.initState();
    completed = widget.todo.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.todo.id),
      onDismissed: (direction) {},
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return await deleteDialog(
            context,
          );
        }
        return null;
      },
      direction: DismissDirection.startToEnd,
      background: ColoredBox(
        color: Colors.red,
        child: Row(
          children: [
            Padding(
              padding: PaddingManager.paddingHorizontal16,
              child: Text(
                'Delete',
                style:
                    context.textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      child: Card(
        child: CheckboxListTile(
          onChanged: (value) {
            if (value != null) {
              setState(() {
                completed = value;
              });
              context.read<TodoOperationsCubit>().edit(
                    EditTodoParam(
                      isCompleted: value,
                      id: widget.todo.id,
                    ),
                  );
            }
          },
          value: completed,
          title: Text(
            widget.todo.todo,
            maxLines: 2,
          ),
        ),
      ),
    );
  }

  Future<bool> deleteDialog(
    BuildContext ctx,
  ) async {
    bool dissmissed = false;
    await showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete the todo'),
          actions: [
            TextButton(
              onPressed: () {
                dissmissed = true;
                ctx.read<TodoOperationsCubit>().delete(IdParam(widget.todo.id));
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
    return dissmissed;
  }
}
