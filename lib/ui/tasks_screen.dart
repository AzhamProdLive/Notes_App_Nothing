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

  }

  @override
  void didChangeDependencies() {

  }

  Widget addTaskButton(BuildContext context,){
    return FloatingActionButton(
      shape: CircleBorder(side: BorderSide(width: 3, color: CustomColors.lightGrey)),
      backgroundColor: CustomColors.backgroundColor,

      onPressed: () {
       _addTask(context);
      },
      tooltip: 'Add Task',
      child: const Icon(Icons.add, color: CustomColors.lightGrey,),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTasks();
    });

    return _buildTaskList(tasks, 0);

    
  }

  Widget _buildTaskList(List<Task> tasks, int ptId) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final subtasks = _getSubtasks(task.id);
        if (tasks[index].parentId == ptId){
        return InkWell(
          onTap: () => {},
          child: Dismissible(
            key: Key(tasks[index].id.toString()),
            onDismissed: (direction) {
              _deleteTask(tasks[index]);
              setState(() {
                tasks.removeAt(index);
              });
            },
            background: Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            child:  Column(
              children: [Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, children: [ Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2, ),
                        borderRadius: const BorderRadius.all(Radius.circular(50))),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(),
                      child:
                      CheckboxListTile(
                        title: Text(tasks[index].task),
                        value: tasks[index].isDone == 1,
                        onChanged: (bool? value) {
                          _toggleTask(tasks[index]);
                        },
                      ),)),
                  Row(children: [

                  IconButton(onPressed:() {
                    _editTask(tasks[index], context);
                  },

                    style: const ButtonStyle(shape: MaterialStatePropertyAll<OutlinedBorder>(CircleBorder(side: BorderSide(width: 3, color: CustomColors.lightGrey)))),
                    icon:
                    Icon(Icons.edit, color: CustomColors.lightGrey,),),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          side: const BorderSide (color: CustomColors.lightGrey, width: 2),
                          borderRadius: BorderRadius.circular(40,),
                        ),
                        onTap: () {
                          _addSubtask(task.id, context);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.add, color: CustomColors.lightGrey),
                            Text('Add Subtask', style: TextStyle(color: CustomColors.lightGrey),),
                          ],
                        ),
                      ),
                    ),
                ],),

                ],),
                if (subtasks.isNotEmpty)
                  Container(
                      height: subtasks.length*150 ,

                      padding: EdgeInsets.only(left: 25.0, right: 0),
                      child: _buildTaskList(subtasks, tasks[index].id)
                  ),
              ],
            ),
          ),);}
      },
    );
  }/*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );*/

  List<Task> _getSubtasks(int parentId) {
    return tasks.where((task) => task.parentId == parentId).toList();
  }


  void _loadTasks() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
    );

    final List<Map<String, dynamic>> maps = await database.query('tasks');


    setState(() {

      tasks = List.generate(maps.length, (index) {
        return Task(
          id: maps[index]['id'],
          task: maps[index]['task'],
          isDone: maps[index]['isDone'],
          parentId: maps[index]['parentId']?? 0,
        );
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {});
    });

  }

  void _loadTasks_dp() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
    );

    final List<Map<String, dynamic>> maps = await database.query('tasks');



    WidgetsBinding.instance.addPostFrameCallback((_) {
      tasks = List.generate(maps.length, (index) {
        return Task(
          id: maps[index]['id'],
          task: maps[index]['task'],
          isDone: maps[index]['isDone'],
          parentId: maps[index]['taskId'] ?? 0,
        );
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {});
    });
  }

    void _addTask(BuildContext context) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Task'),
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

                    _loadTasks_dp();
                  didChangeDependencies();


                  Navigator.of(context).pop();
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    }


  void _addSubtask(int parentId, BuildContext context) async {
    final TextEditingController _textEditingController =
    TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Subtask'),
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
                // Add the subtask to the database
                await _insertTask(_textEditingController.text,
                    parentId: parentId);

                // Reload the tasks from the database
                _loadTasks_dp();
                didChangeDependencies();

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

    Future<void> _insertTask(String task,  {int? parentId}) async {
      final Database database = await openDatabase(
        join(await getDatabasesPath(), 'tasks_database.db'),
      );

      await database.insert('tasks', {'task': task, 'parentId': parentId});
    }

    Future<void> _toggleTask(Task task) async {
      final Database database = await openDatabase(
        join(await getDatabasesPath(), 'tasks_database.db'),
      );

      int newIsDone = task.isDone == 1 ? 0 : 1;

      await database.update(
        'tasks',
        {'isDone': newIsDone},
        where: 'id = ?',
        whereArgs: [task.id],
      );

      // Reload the tasks from the database

    }

    void _editTask(Task task, BuildContext context) async {
      final TextEditingController _editingController =
      TextEditingController(text: task.task);

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Task'),
            content: TextField(
              controller: _editingController,
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
                  // Update the task in the database
                  await _updateTask(task.id, _editingController.text);

                  // Reload the tasks from the database
                  _loadTasks();

                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
    }

  Future<void> _updateTask(int taskId, String updatedTask) async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
    );

    await database.update(
      'tasks',
      {'task': updatedTask},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

    Future<void> _deleteTask(Task task) async {
      final Database database = await openDatabase(
        join(await getDatabasesPath(), 'tasks_database.db'),
      );

      await database.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [task.id],
      );

      // Reload the tasks from the database
      _loadTasks();
    }
  }

class Task {
  final int id;
  final String task;
  final int isDone;
  final int parentId;

  Task({required this.id, required this.task, required this.isDone, required this.parentId});
}

Widget addTaskButton(BuildContext context) {
  _TaskListScreenState taskListScreenState = _TaskListScreenState();
  return  taskListScreenState.addTaskButton(context);
}