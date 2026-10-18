import 'package:flutter/foundation.dart';

import '../data/task_repository.dart';
import '../domain/task_models.dart';

enum TaskFilter { all, todo, inProgress, done }

class TaskController extends ChangeNotifier {
  TaskController(this._repository);

  final TaskRepository _repository;
  List<Task> _tasks = const [];
  TaskFilter _filter = TaskFilter.all;
  bool isLoading = false;
  String? errorMessage;

  List<Task> get tasks => List.unmodifiable(_tasks);
  TaskFilter get filter => _filter;
  int get completedCount =>
      _tasks.where((task) => task.status == TaskStatus.done).length;
  double get completionRate =>
      _tasks.isEmpty ? 0 : completedCount / _tasks.length;

  List<Task> get visibleTasks {
    return _tasks.where((task) {
      return switch (_filter) {
        TaskFilter.all => true,
        TaskFilter.todo => task.status == TaskStatus.todo,
        TaskFilter.inProgress => task.status == TaskStatus.inProgress,
        TaskFilter.done => task.status == TaskStatus.done,
      };
    }).toList();
  }

  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      _tasks = await _repository.loadTasks();
    } catch (_) {
      errorMessage = 'Unable to load tasks right now.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setFilter(TaskFilter value) {
    _filter = value;
    notifyListeners();
  }

  void cycleStatus(String taskId) {
    _tasks = _tasks.map((task) {
      if (task.id != taskId) return task;
      final next = switch (task.status) {
        TaskStatus.todo => TaskStatus.inProgress,
        TaskStatus.inProgress => TaskStatus.done,
        TaskStatus.done => TaskStatus.todo,
      };
      return task.copyWith(status: next);
    }).toList();
    notifyListeners();
  }
}
