import '../domain/task_models.dart';

abstract interface class TaskRepository {
  Future<List<Task>> loadTasks();
}

class MockTaskRepository implements TaskRepository {
  @override
  Future<List<Task>> loadTasks() async {
    return const [
      Task(
        id: 'task-1',
        title: 'Define the first release scope',
        project: 'Atlas mobile',
        status: TaskStatus.inProgress,
        priority: TaskPriority.high,
        dueLabel: 'Today',
      ),
      Task(
        id: 'task-2',
        title: 'Create the empty state illustration',
        project: 'Atlas mobile',
        status: TaskStatus.todo,
        priority: TaskPriority.medium,
        dueLabel: 'Tomorrow',
      ),
      Task(
        id: 'task-3',
        title: 'Write the onboarding notes',
        project: 'Internal docs',
        status: TaskStatus.done,
        priority: TaskPriority.low,
        dueLabel: 'Completed',
      ),
      Task(
        id: 'task-4',
        title: 'Review the repository boundary',
        project: 'Architecture',
        status: TaskStatus.todo,
        priority: TaskPriority.high,
        dueLabel: 'Friday',
      ),
    ];
  }
}
