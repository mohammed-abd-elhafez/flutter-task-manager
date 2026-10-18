enum TaskStatus { todo, inProgress, done }

enum TaskPriority { low, medium, high }

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.project,
    required this.status,
    required this.priority,
    required this.dueLabel,
  });

  final String id;
  final String title;
  final String project;
  final TaskStatus status;
  final TaskPriority priority;
  final String dueLabel;

  Task copyWith({TaskStatus? status}) {
    return Task(
      id: id,
      title: title,
      project: project,
      status: status ?? this.status,
      priority: priority,
      dueLabel: dueLabel,
    );
  }
}
