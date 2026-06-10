import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String category = 'Trabajo';
  String priority = 'Alta';
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva tarea')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 3,
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(labelText: 'Categoría'),
              items: const [
                DropdownMenuItem(value: 'Trabajo', child: Text('Trabajo')),
                DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                DropdownMenuItem(value: 'Estudio', child: Text('Estudio')),
                DropdownMenuItem(value: 'Urgente', child: Text('Urgente')),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() => category = value);
              },
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: priority,
              decoration: const InputDecoration(labelText: 'Prioridad'),
              items: const [
                DropdownMenuItem(value: 'Alta', child: Text('Alta')),
                DropdownMenuItem(value: 'Media', child: Text('Media')),
                DropdownMenuItem(value: 'Baja', child: Text('Baja')),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() => priority = value);
              },
            ),

            const SizedBox(height: 15),

            ListTile(
              title: Text(
                'Fecha límite: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: pickDate,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final task = Task(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    description: descriptionController.text,
                    category: category,
                    priority: priority,
                    dueDate: selectedDate,
                  );

                  Provider.of<TaskProvider>(
                    context,
                    listen: false,
                  ).addTask(task);

                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}