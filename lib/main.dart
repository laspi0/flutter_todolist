import 'package:flutter/material.dart';

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
                hintText: "Enter your todo",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTodo();
            },
            child: Text('Add'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.tealAccent, // Set card background color
                  child: ListTile(
                    title: Text(_todos[index].text),
                    subtitle: Text(
                      'Created on: ${_todos[index].date.toString()}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeTodo(index),
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
