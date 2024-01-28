import 'package:flutter/material.dart';
import 'package:todoist/classes/todo.dart';
import 'package:todoist/pages/home-page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyTodoListState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade300),
          useMaterial3: true,
        ),
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyTodoListState extends ChangeNotifier {
  final List<Todo> todos = <Todo>[
    Todo(title: 'Выучить Go', completed: false),
  ];
  final TextEditingController textEditingController = TextEditingController();

  void addTodoItem(String name) {
    if (name.isEmpty) return;

    todos.add(Todo(title: name, completed: false));
    textEditingController.clear();
    notifyListeners();
  }

  void removeTodoItem(Todo todo) {
    todos.removeWhere((element) => element.title == todo.title);
    notifyListeners();
  }

  void checkTodo(Todo todo) {
    todo.completed = !todo.completed;
    notifyListeners();
  }
}
