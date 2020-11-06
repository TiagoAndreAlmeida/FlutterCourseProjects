import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:task_list/componets/itemList.dart';
import 'package:task_list/models/TodoItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lista de tarefas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalStorage storage = new LocalStorage('list_task');
  List<TodoItem> _todoList = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getStorage();
  }

  void _addTask() {
    setState(() {
      TodoItem newItem = TodoItem(title: _controller.text, done: false);
      _controller.clear();
      _todoList.add(newItem);
      _saveStorage();
    });
  }

  void _toggleDoneTask(int index, bool value) {
    setState(() {
      _todoList[index].done = value;
    });
    _sortList();
  }

  void _removeItem(int index) {
    setState(() {
      _todoList.removeAt(index);
      _saveStorage();
    });
  }

  Future<void> _sortList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _todoList.sort((a, b) => a.done && !b.done ? 1 : 0);
      _todoList = _todoList;
    });
    _saveStorage();
  }

  Future<void> _getStorage() async {
    await storage.ready;
    dynamic data = json.decode(await storage.getItem("itens"));
    List<TodoItem> _storageItens = [];

    for (Map<String, dynamic> item in data) {
      TodoItem _todo = new TodoItem.fromJson(item);
      _storageItens.add(_todo);
    }
    setState(() {
      _todoList = _storageItens;
    });
  }

  Future<void> _saveStorage() async {
    //List data = _todoList.map((e) => e.toJSON()).toList();
    await storage.setItem("itens", json.encode(_todoList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 8, 7, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: "Nova tarefa"),
                  )),
                  RaisedButton(child: Text("ADD"), onPressed: _addTask)
                ],
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: _sortList,
                child: ListView.builder(
                    itemCount: _todoList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(_todoList[index].id.toString()),
                        direction: DismissDirection.startToEnd,
                        background: Container(
                            color: Colors.red,
                            child: Align(
                              alignment: Alignment(-0.9, 0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            )),
                        child: itemList(_todoList[index], (value) {
                          _toggleDoneTask(index, value);
                        }),
                        onDismissed: (direction) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Tarefa ${_todoList[index].title.toString()} foi removida")));
                          _removeItem(index);
                        },
                      );
                    }),
              ))
            ],
          ),
        ));
  }
}
