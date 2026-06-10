class Task {
  String id;
  String title;
  String description;
  String category;
  String priority;
  DateTime dueDate;
  bool completed;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
    this.completed = false,
  });
}