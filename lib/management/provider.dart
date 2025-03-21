import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/taskmodel.dart';
import 'package:task_manager_app/utils/shared_preference.dart';

class TaskProvider with ChangeNotifier {
  List<Taskmodel> _tasks = [];

  List<Taskmodel> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  Future<void> saveTasks() async {
    List<Map<String, dynamic>> taskList =
        _tasks
            .map(
              (task) => {
                'title': task.title,
                'description': task.description,
                'isCompleted': task.isCompleted,
              },
            )
            .toList();

    await SharedPreferenceHelper.saveData(taskList);
    notifyListeners();
  }

// task shown on ui by the method of load task

  Future<void> loadTasks() async {
    List<Map<String, dynamic>> loadedTasks =
        await SharedPreferenceHelper.loadTasks();

    _tasks =
        loadedTasks
            .map(
              (task) => Taskmodel(
                title: task['title']!,
                description: task['description']!,
                isCompleted: task['isCompleted'] ?? false,
              ),
            )
            .toList();

    notifyListeners();
  }

  void addTask(String title, String description) {
    _tasks.add(Taskmodel(title: title, description: description));
    saveTasks();
  }

  void editTask(int index, String newTitle, String newDescription) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = Taskmodel(
        title: newTitle,
        description: newDescription,
        isCompleted: _tasks[index].isCompleted,
      );
      saveTasks();
    }
  }
// checking the task
  void toggleTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      saveTasks();
    }
  }


// for delete
  void deleteTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      saveTasks();
    }
  }
}
