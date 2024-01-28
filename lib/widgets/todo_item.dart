import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist/classes/todo.dart';
import 'package:todoist/main.dart';
import 'package:todoist/widgets/my-custom-checkbox.dart';
import 'package:todoist/widgets/switch-example.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});
  final Todo todo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyTodoListState>();

    return ListTile(
      onTap: () {
        appState.checkTodo(todo);
      },
      leading: MyCustomCheckBox(
        isChecked: todo.completed,
        onChanged: (value) {
          appState.checkTodo(todo);
        },
      ),
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              todo.title,
              style: _getTextStyle(todo.completed),
            ),
          ),
          IconButton(
            onPressed: () {
              appState.removeTodoItem(todo);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}
