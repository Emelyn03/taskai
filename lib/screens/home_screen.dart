import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import 'add_task_screen.dart';
import 'stats_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskAI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const StatsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButton<String>(
              value: provider.statusFilter,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'Todas',
                  child: Text('Todas'),
                ),
                DropdownMenuItem(
                  value: 'Pendientes',
                  child: Text('Pendientes'),
                ),
                DropdownMenuItem(
                  value: 'Completadas',
                  child: Text('Completadas'),
                ),
              ],
              onChanged: (value) {
                provider.setStatusFilter(value!);
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButton<String>(
              value: provider.categoryFilter,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'Todas',
                  child: Text('Todas las categorías'),
                ),
                DropdownMenuItem(
                  value: 'Trabajo',
                  child: Text('Trabajo'),
                ),
                DropdownMenuItem(
                  value: 'Personal',
                  child: Text('Personal'),
                ),
                DropdownMenuItem(
                  value: 'Estudio',
                  child: Text('Estudio'),
                ),
                DropdownMenuItem(
                  value: 'Urgente',
                  child: Text('Urgente'),
                ),
              ],
              onChanged: (value) {
                provider.setCategoryFilter(value!);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount:
                  provider.filteredTasks.length,
              itemBuilder: (context, index) {
                final task =
                    provider.filteredTasks[index];

                return Dismissible(
                  key: Key(task.id),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (_) {
                    provider.deleteTask(task.id);
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: task.completed,
                      onChanged: (_) {
                        provider.toggleTask(
                            task.id);
                      },
                    ),
                    title: Text(task.title),
                    subtitle: Text(
                      '${task.category} - ${task.priority}\n'
                      'Fecha: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              EditTaskScreen(
                            task: task,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddTaskScreen(),
            ),
          );
        },
      ),
    );
  }
}