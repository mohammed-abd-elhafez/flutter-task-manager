import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_task_manager/features/tasks/data/task_repository.dart';
import 'package:flutter_task_manager/features/tasks/presentation/task_controller.dart';
import 'package:flutter_task_manager/features/tasks/domain/task_models.dart';

void main() {
  test('loads tasks and calculates progress', () async {
    final controller = TaskController(MockTaskRepository());
    await controller.load();

    expect(controller.tasks, hasLength(4));
    expect(controller.completedCount, 1);
    expect(controller.completionRate, 0.25);
  });

  test('cycles a task through its workflow', () async {
    final controller = TaskController(MockTaskRepository());
    await controller.load();

    controller.cycleStatus('task-2');
    expect(
      controller.tasks.firstWhere((task) => task.id == 'task-2').status,
      TaskStatus.inProgress,
    );
    controller.cycleStatus('task-2');
    expect(
      controller.tasks.firstWhere((task) => task.id == 'task-2').status,
      TaskStatus.done,
    );
    controller.cycleStatus('task-2');
    expect(
      controller.tasks.firstWhere((task) => task.id == 'task-2').status,
      TaskStatus.todo,
    );
  });

  test('filters visible tasks by workflow status', () async {
    final controller = TaskController(MockTaskRepository());
    await controller.load();

    controller.setFilter(TaskFilter.done);

    expect(controller.visibleTasks, hasLength(1));
    expect(controller.visibleTasks.single.status, TaskStatus.done);
  });
}
