import 'package:flutter/material.dart';

import '../domain/task_models.dart';
import 'task_card.dart';
import 'task_controller.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({required this.controller, super.key});

  final TaskController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final theme = Theme.of(context);
        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth > 720;
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1080),
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: wide ? 48 : 20,
                        vertical: 28,
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'GOOD MORNING, MO.',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      letterSpacing: 1.5,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Make progress visible.',
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: theme.colorScheme.primary,
                              child: const Text(
                                'M',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: _SummaryCard(
                                label: 'Completed',
                                value:
                                    '${controller.completedCount}/${controller.tasks.length}',
                                icon: Icons.task_alt,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SummaryCard(
                                label: 'Progress',
                                value:
                                    '${(controller.completionRate * 100).round()}%',
                                icon: Icons.insights,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Text(
                          'Your tasks',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (final filter in TaskFilter.values)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text(_filterLabel(filter)),
                                    selected: controller.filter == filter,
                                    onSelected: (_) =>
                                        controller.setFilter(filter),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        if (controller.isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else if (controller.errorMessage != null)
                          _ErrorState(
                            message: controller.errorMessage!,
                            onRetry: controller.load,
                          )
                        else if (controller.visibleTasks.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Text('No tasks in this view.'),
                            ),
                          )
                        else
                          for (final task in controller.visibleTasks) ...[
                            TaskCard(
                              task: task,
                              onTap: () {
                                final nextStatus = controller.cycleStatus(task.id);
                                if (nextStatus != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${task.title} moved to ${nextStatus.label}.',
                                      ),
                                      duration: const Duration(milliseconds: 1200),
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        const SizedBox(height: 18),
                        Text(
                          'Tip: tap a task to move it through its workflow.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  String _filterLabel(TaskFilter filter) => switch (filter) {
    TaskFilter.all => 'All',
    TaskFilter.todo => 'To do',
    TaskFilter.inProgress => 'In progress',
    TaskFilter.done => 'Done',
  };
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(label, style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      children: [
        Text(message),
        const SizedBox(height: 12),
        FilledButton(onPressed: onRetry, child: const Text('Retry')),
      ],
    ),
  );
}
