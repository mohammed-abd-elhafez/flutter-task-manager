import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_task_manager/features/tasks/data/task_repository.dart';
import 'package:flutter_task_manager/features/tasks/presentation/task_controller.dart';
import 'package:flutter_task_manager/features/tasks/presentation/task_page.dart';

void main() {
  testWidgets('renders task dashboard', (tester) async {
    final controller = TaskController(MockTaskRepository())..load();
    await tester.pumpWidget(
      MaterialApp(home: TaskPage(controller: controller)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Make progress visible.'), findsOneWidget);
    expect(find.text('Define the first release scope'), findsOneWidget);
    controller.dispose();
  });
}
