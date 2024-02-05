import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Widget addTaskButton(BuildContext context,){
    return FloatingActionButton(
      backgroundColor: CustomColors.red,
      onPressed: () {
       _addTask(context);
      },
      tooltip: 'Add Task',
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                  ),
                  child: ListTile(
                      title: Text(tasks[index].task),
          ),),),);
        },
      );/*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );*/
  }

  void _loadTasks() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
    );

    final List<Map<String, dynamic>> maps = await database.query('tasks');

    setState(() {
      tasks = List.generate(maps.length, (index) {
        return Task(id: maps[index]['id'], task: maps[index]['task']);
      });
    });
  }

  void _addTask(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: _textEditingController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add the task to the database
                await _insertTask(_textEditingController.text);

                // Reload the tasks from the database
                _loadTasks();

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _insertTask(String task) async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
    );

    await database.insert('tasks', {'task': task});
  }


}

class Task {
  final int id;
  final String task;

  Task({required this.id, required this.task});
}

Widget addTaskButton(BuildContext context) {
  _TaskListScreenState taskListScreenState = _TaskListScreenState();
  return  taskListScreenState.addTaskButton(context);
}