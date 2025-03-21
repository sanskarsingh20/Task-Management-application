import 'package:flutter/material.dart';
import 'package:task_manager_app/data/taskmodel.dart';
import 'package:task_manager_app/screen/addtask.dart';
import 'package:task_manager_app/management/provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Wollo Tasks', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                if (taskProvider.tasks.isEmpty) {
                  return Center(
                    child: Text(
                      'No tasks added yet!',
                      style: TextStyle(color: Colors.grey[400], fontSize: 18),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      Taskmodel task = taskProvider.tasks[index];
                      return Card(
                        color: Colors.grey[850],
                        elevation: 3,
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          subtitle: Text(
                            task.description,
                            style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 16,
                            ),
                          ),
                          leading: Checkbox(
                            activeColor: Colors.green,
                            checkColor: Colors.black,
                            value: task.isCompleted,
                            onChanged: (value) {
                              Provider.of<TaskProvider>(
                                context,
                                listen: false,
                              ).toggleTask(index);
                            },
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          backgroundColor: Colors.grey[900],
                                          contentPadding: EdgeInsets.zero,
                                          insetPadding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          content: AddTask(
                                            task: task,
                                            index: index,
                                          ),
                                        ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  Provider.of<TaskProvider>(
                                    context,
                                    listen: false,
                                  ).deleteTask(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.grey[900],
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.symmetric(horizontal: 20),
                  content: AddTask(),
                ),
          );
        },
        backgroundColor: Colors.grey[800],
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
