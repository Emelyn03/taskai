import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  String statusFilter = 'Todas';
  String categoryFilter = 'Todas';

  void setStatusFilter(String value) {
    statusFilter = value;
    notifyListeners();
  }

  void setCategoryFilter(String value) {
    categoryFilter = value;
    notifyListeners();
  }

  List<Task> get filteredTasks {
    return _tasks.where((task) {
      bool statusMatch = true;
      bool categoryMatch = true;

      if (statusFilter == 'Pendientes') {
        statusMatch = !task.completed;
      }

      if (statusFilter == 'Completadas') {
        statusMatch = task.completed;
      }

      if (categoryFilter != 'Todas') {
        categoryMatch =
            task.category == categoryFilter;
      }

      return statusMatch && categoryMatch;
    }).toList();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere(
      (task) => task.id == id,
    );
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere(
      (task) => task.id == updatedTask.id,
    );

    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void toggleTask(String id) {
    int index = _tasks.indexWhere(
      (task) => task.id == id,
    );

    if (index != -1) {
      _tasks[index].completed =
          !_tasks[index].completed;

      notifyListeners();
    }
  }
}