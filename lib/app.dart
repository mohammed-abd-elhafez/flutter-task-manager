import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/tasks/data/task_repository.dart';
import 'features/tasks/presentation/task_controller.dart';
import 'features/tasks/presentation/task_page.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  late final TaskController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TaskController(MockTaskRepository())..load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: AppTheme.dark(),
      home: TaskPage(controller: _controller),
    );
  }
}
