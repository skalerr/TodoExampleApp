import 'package:flutter/material.dart';
import 'package:todoist/classes/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onTodoChanged,
      required this.onRemoveTodo});

  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) onRemoveTodo;
  final Todo todo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: Checkbox(
        checkColor: Colors.greenAccent,
        value: todo.completed,
        onChanged: (value) {
          onTodoChanged(todo);
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
              onRemoveTodo(todo);
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
