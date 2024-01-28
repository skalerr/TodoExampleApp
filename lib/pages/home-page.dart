import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist/classes/todo.dart';
import 'package:todoist/main.dart';
import 'package:todoist/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyTodoListState>();

    const double textSize = 22;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: appState.todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Todo todo = appState.todos[index];
                      return TodoItem(
                        todo: todo,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: appState.textEditingController,
                          decoration: const InputDecoration(
                            hintText: 'Type something...',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: appState.addTodoItem,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextButton(
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Добавить",
                        style: TextStyle(fontSize: textSize),
                      ),
                    ),
                    onPressed: () {
                      appState.addTodoItem(appState.textEditingController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _displayDialog(), //_addTodoItem(),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Future<void> _displayDialog() async {
    var appState = context.watch<MyTodoListState>();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: TextField(
            controller: appState.textEditingController,
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
                appState.addTodoItem(appState.textEditingController.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
