import 'package:flutter/material.dart';
import 'package:todoist/classes/todo.dart';
import 'package:todoist/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Todo> _todos = <Todo>[
    Todo(title: 'Что бы добавить, нажми плюсик', completed: false)
  ];
  final TextEditingController _textEditingController = TextEditingController();

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(title: name, completed: false));
    });
    _textEditingController.clear();
  }

  void _removeTodoItem(Todo todo) {
    setState(() {
      _todos.removeWhere((element) => element.title == todo.title);
    });
  }

  void _checkTodo(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: 'Type your todo'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textEditingController.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double textSize = 22;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: _todos.map((Todo todo) {
              return TodoItem(
                todo: todo,
                onTodoChanged: _checkTodo,
                onRemoveTodo: _removeTodoItem,
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(), //_addTodoItem(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBottomSheet() {
    TextEditingController _textController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Введите что-то...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // Обработка отправки текста из поля ввода
              String text = _textController.text;
              // Добавьте вашу логику отправки текста здесь
              _textController.clear();
            },
          ),
        ],
      ),
    );
  }
}
