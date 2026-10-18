import 'package:flutter/material.dart';

import '../domain/task_models.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, required this.onTap, super.key});

  final Task task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDone = task.status == TaskStatus.done;
    final priorityColor = switch (task.priority) {
      TaskPriority.high => Colors.orangeAccent,
      TaskPriority.medium => Colors.blueAccent,
      TaskPriority.low => Colors.grey,
    };

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(
                isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isDone ? theme.colorScheme.primary : Colors.white38,
                size: 28,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        decoration: isDone ? TextDecoration.lineThrough : null,
                        color: isDone ? Colors.white54 : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${task.project}  •  ${task.dueLabel}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: priorityColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
