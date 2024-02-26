import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoItem> _todos = [];
  TextEditingController _textFieldController = TextEditingController();

  void _addTodo() {
    setState(() {
      if (_textFieldController.text.isNotEmpty) {
        _todos.add(
          TodoItem(
            text: _textFieldController.text,
            date: DateTime.now(),
          ),
        );
        _textFieldController.clear();
      }
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: "Creer votre tache",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTodo();
            },
            child: Text('Ajouter'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                final formattedDate =
                    DateFormat.yMMMd().add_Hms().format(todo.date);
                return Dismissible(
                  key: Key(todo.text),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _removeTodo(index);
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.teal),
                    ),
                    child: ListTile(
                      title: Text(todo.text),
                      subtitle: Text('Created on: $formattedDate'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  final String text;
  final DateTime date;

  TodoItem({required this.text, required this.date});
}
