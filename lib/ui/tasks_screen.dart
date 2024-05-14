import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

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
  void didChangeDependencies() {}

  Widget addTaskButton(
    BuildContext context,
  ) {
    return FloatingActionButton(
      shape: const CircleBorder(
          side: BorderSide()),
      backgroundColor: CustomColors.lightGrey,
      onPressed: () {
        _addTask(context);
      },
      tooltip: 'Add Task',
      child: const Icon(
        Icons.add,
        color: CustomColors.backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTasks();
    });

    return _buildTaskList(tasks, 0, 0);
  }

  Widget _buildTaskList(List<Task> tasks, int ptId, int sublistNR) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final subtasks = _getSubtasks(task.id);
        if (tasks[index].parentId == ptId && sublistNR < 3) {
          return taskWidget(tasks, index, subtasks, ptId, sublistNR, context);
        } else {
          return Container();
        }
      },
    );
  } /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );*/

  Widget taskWidget(List<Task> tasks, int index, List<Task> subtasks, int ptId,
      int sublistNR, BuildContext context) {
    final task = tasks[index];
    return Column(
      children: [
        Dismissible(
            confirmDismiss: (DismissDirection direction) async {
              _deleteTask(tasks[index]);
              super.setState(() {
                tasks.removeAt(index);
              });

              for (var subtask in subtasks) {
                _deleteTask(subtask);
              }
              return null;
            },
            key: Key(task.id.toString()),
            direction: DismissDirection.horizontal,
            background: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.backgroundColor,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(14))),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.delete_outline,
                    color: CustomColors.whiteMain,
                  ),
                ),
              ),
            ),
            child: Builder(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: taskBackgroundColor(tasks[index].isDone),
                            border: Border.all(
                              width: 2,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(14))),
                        child: Container(
                          padding: taskPadding(sublistNR),
                          decoration: const BoxDecoration(),
                          child: CheckboxListTile(
                            checkboxShape: const CircleBorder(
                                side: BorderSide(
                              color: CustomColors.backgroundColor,
                            )),
                            title: Row(children: [
                              Text(tasks[index].task,
                                  style: const TextStyle(
                                      color: CustomColors.backgroundColor)),
                              addTask(sublistNR, _taskWidget(
                                task,
                                context,
                                ptId,
                                sublistNR,
                              ))

                            ],),
                            value: tasks[index].isDone == 1,
                            onChanged: (bool? value) {
                              _toggleTask(tasks[index]);
                            },
                          ),
                        )),
                  ],
                );
              },
            )),
      ],
    );
  }

  List<Task> _getSubtasks(int parentId) {
    return tasks.where((task) => task.parentId == parentId).toList();
  }

  Color taskBackgroundColor(int isDone) {
    if (isDone == 1) {
      return CustomColors.lightGrey;
    } else {
      return CustomColors.whiteMain;
    }
  }

  Widget addTask(int sublistNR,Widget TaskW ){
    if (sublistNR < 2){
     return TaskW;}else{
      return Container();
    }

  }

  EdgeInsets taskPadding(int sublistNR) {
    if (sublistNR == 0) {
      return const EdgeInsets.all(3);
    } else {
      return const EdgeInsets.all(0);
    }
  }

  EdgeInsets _taskWidgetPadding(int sublistNR) {
    if (sublistNR == 0) {
      return const EdgeInsets.only(left: 15, bottom: 10);
    } else {
      return const EdgeInsets.only(
        left: 15,
      );
    }
  }

  List<Widget> subtasksWidget(
      int parentId, int sublistNR, BuildContext context) {
    List<Widget> subtaskslist = [];
    var subtasks = _getSubtasks(parentId);
    for (var i = 0; i < subtasks.length; i++) {
      subtaskslist.add(taskWidget(subtasks, i, _getSubtasks(subtasks[i].id),
          parentId, sublistNR + 1, context));
    }
    subtaskslist.add(Container(
      height: 10,
    ));
    return subtaskslist;
  }

  Widget _taskWidget(
    Task task,
    BuildContext context,
    int ptId,
    int sublistNR,
  ) {
    var subtasks = _getSubtasks(task.id);
    if (subtasks.isNotEmpty && task.isDone == 0) {
      return ExpansionTile(
          shape: const RoundedRectangleBorder(
            side: BorderSide( width: 5),
            borderRadius: BorderRadius.all(Radius.circular((30))),
          ),
          backgroundColor: CustomColors.greyHint,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
          collapsedTextColor: CustomColors.whiteMain,
          collapsedIconColor: CustomColors.red,
          iconColor: CustomColors.whiteMain,
          title: InkWell(
            splashColor: CustomColors.whiteMain,
            customBorder: RoundedRectangleBorder(
              side: const BorderSide( width: 2),
              borderRadius: BorderRadius.circular(
                40,
              ),
            ),
            onTap: () {
              _addSubtask(task.id, context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustomColors.whiteMain,
                      border: Border.all(
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  padding: EdgeInsets.zero,
                  child: const Icon(Icons.add,
                      color: CustomColors.backgroundColor),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: CustomColors.whiteMain,
                      border: Border.all(
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _stringSubtask_s(subtasks),
                    style: const TextStyle(
                        color: CustomColors.backgroundColor, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          //subtitle: Text('Trailing expansion arrow icon'),
          children: subtasksWidget(task.id, sublistNR, context));
    } else if (task.isDone == 0) {
      return Padding(
        padding: _taskWidgetPadding(sublistNR),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              side: const BorderSide( width: 2),
              borderRadius: BorderRadius.circular(
                40,
              ),
            ),
            onTap: () {
              _addSubtask(task.id, context);
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustomColors.whiteMain,
                      border: Border.all(
                        width: 2,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: const Icon(Icons.add, color: CustomColors.lightGrey),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: 10,
      );
    }
  }

  String _stringSubtask_s(List<Task> subtasks) {
    if (subtasks.length > 1) {
      return "Subtasks";
    } else {
      return "Subtask";
    }
  }

  Color _taskWidget_color(int sublistNR) {
    if (sublistNR > 0) {
      return CustomColors.backgroundColor;
    } else {
      return CustomColors.whiteMain;
    }
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
          parentId: maps[index]['parentId'] ?? 0,
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
          surfaceTintColor: Colors.black,
          backgroundColor: CustomColors.lightGrey,
          title: const Text(
            'Add Task',
            style: TextStyle(fontSize: 20),
          ),
          content: TextField(
            decoration: InputDecoration(
              fillColor: CustomColors.backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
            controller: _textEditingController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(color: CustomColors.red)),
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
              child: const Text(
                'Add',
                style: TextStyle(color: CustomColors.whiteMain),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addSubtask(int parentId, BuildContext context) async {
    final TextEditingController textEditingController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add Subtask',
            style: TextStyle(fontSize: 20),
          ),
          content: TextField(
            decoration: InputDecoration(
              fillColor: CustomColors.greyHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
            controller: textEditingController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(color: CustomColors.red)),
            ),
            TextButton(
              onPressed: () async {
                // Add the subtask to the database
                await _insertTask(textEditingController.text,
                    parentId: parentId);

                // Reload the tasks from the database
                _loadTasks_dp();
                didChangeDependencies();

                Navigator.of(context).pop();
              },
              child: const Text('Add',
                  style: TextStyle(color: CustomColors.whiteMain)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _insertTask(String task, {int? parentId}) async {
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
    final TextEditingController editingController =
        TextEditingController(text: task.task);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editingController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Update the task in the database
                await _updateTask(task.id, editingController.text);

                // Reload the tasks from the database
                _loadTasks();

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
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

  Task(
      {required this.id,
      required this.task,
      required this.isDone,
      required this.parentId});
}

Widget addTaskButton(BuildContext context) {
  _TaskListScreenState taskListScreenState = _TaskListScreenState();
  return taskListScreenState.addTaskButton(context);
}
