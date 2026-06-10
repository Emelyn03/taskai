import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks =
        Provider.of<TaskProvider>(context).tasks;

    final completed =
        tasks.where((t) => t.completed).length;

    final pending =
        tasks.where((t) => !t.completed).length;

    final trabajo = tasks
        .where((t) => t.category == 'Trabajo')
        .length;

    final personal = tasks
        .where((t) => t.category == 'Personal')
        .length;

    final estudio = tasks
        .where((t) => t.category == 'Estudio')
        .length;

    final urgente = tasks
        .where((t) => t.category == 'Urgente')
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Total de tareas',
              ),
              trailing: Text(
                tasks.length.toString(),
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Pendientes',
              ),
              trailing: Text(
                pending.toString(),
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Completadas',
              ),
              trailing: Text(
                completed.toString(),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Por categoría',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Trabajo',
              ),
              trailing: Text(
                trabajo.toString(),
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Personal',
              ),
              trailing: Text(
                personal.toString(),
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Estudio',
              ),
              trailing: Text(
                estudio.toString(),
              ),
            ),
          ),

          Card(
            child: ListTile(
              title: const Text(
                'Urgente',
              ),
              trailing: Text(
                urgente.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}