import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  String statusFilter = 'Todas';
  String categoryFilter = 'Todas';

  TaskProvider() {
    _loadDemoTasks();
  }

  void _loadDemoTasks() {
    _tasks.addAll([
      Task(
        id: '1',
        title: 'Comprar materiales para proyecto',
        description: 'Comprar cuadernos, bolígrafos y materiales para la presentación.',
        category: 'Trabajo',
        priority: 'Media',
        dueDate: DateTime.now().add(const Duration(days: 2)),
      ),
      Task(
        id: '2',
        title: 'Estudiar Flutter Provider',
        description: 'Repasar el patrón Provider y actualizar la tarea de estado.',
        category: 'Estudio',
        priority: 'Alta',
        dueDate: DateTime.now().add(const Duration(days: 4)),
      ),
      Task(
        id: '3',
        title: 'Pagar factura internet',
        description: 'Realizar el pago de internet antes de la fecha de corte.',
        category: 'Personal',
        priority: 'Baja',
        dueDate: DateTime.now().add(const Duration(days: 6)),
      ),
      Task(
        id: '4',
        title: 'Entrega urgente laboratorio',
        description: 'Completar el informe del laboratorio y subirlo al aula virtual.',
        category: 'Urgente',
        priority: 'Alta',
        dueDate: DateTime.now().add(const Duration(days: 1)),
      ),
    ]);
  }

  List<Task> get tasks => List.unmodifiable(_tasks);

  List<Task> get filteredTasks {
    return _tasks.where((task) {
      final statusMatch = statusFilter == 'Todas' ||
          (statusFilter == 'Pendientes' && !task.isCompleted) ||
          (statusFilter == 'Completadas' && task.isCompleted);

      final categoryMatch = categoryFilter == 'Todas' ||
          task.category == categoryFilter;

      return statusMatch && categoryMatch;
    }).toList();
  }

  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
  int get pendingTasks => _tasks.where((task) => !task.isCompleted).length;
  int countByCategory(String category) {
    return _tasks.where((task) => task.category == category).length;
  }

  void addTask(Task task) {
    _tasks.insert(0, task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  void setCategoryFilter(String value) {
    categoryFilter = value;
    notifyListeners();
  }

  void setStatusFilter(String value) {
    statusFilter = value;
    notifyListeners();
  }
}
