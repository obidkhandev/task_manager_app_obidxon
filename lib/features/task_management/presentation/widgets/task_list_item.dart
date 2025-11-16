import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/utils/enums.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
// Removed localization for simplicity

import 'slide_fade_in.dart';
import 'package:task_manager/features/task_management/data/models/task_extensions.dart';
import 'package:task_manager/generated/l10n.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.entry,
    required this.index,
    required this.onToggleComplete,
    required this.onDelete,
    required this.onTap,
  });

  final (int, Task) entry;
  final int index;
  final ValueChanged<bool?> onToggleComplete;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final (key, task) = entry;
    final date = DateFormat.yMMMd().add_Hm().format(task.createdAt);
    final textStyle = (task.status == TaskStatus.done)
        ? const TextStyle(decoration: TextDecoration.lineThrough)
        : const TextStyle();

    return SlideFadeIn(
      delay: Duration(milliseconds: 30 * index),
      child: Card(
        child: ListTile(
          onTap: onTap,
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: onToggleComplete,
          ),
          title: Text(task.title, style: textStyle),
          subtitle: Text('${S.of(context).created(date)} • ${_priorityLabel(context, task.priority)} • ${_groupLabel(context, task.group)}'),
          trailing: IconButton(
            tooltip: 'Delete',
            icon: const Icon(Icons.delete_outline),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }

  String _priorityLabel(BuildContext context, Priority p) {
    final s = S.of(context);
    switch (p) {
      case Priority.low:
        return s.low;
      case Priority.medium:
        return s.medium;
      case Priority.high:
        return s.high;
    }
  }

  String _groupLabel(BuildContext context, TaskGroup g) {
    final s = S.of(context);
    switch (g) {
      case TaskGroup.work:
        return s.work;
      case TaskGroup.study:
        return s.study;
      case TaskGroup.gym:
        return s.gym;
      case TaskGroup.personal:
        return s.personal;
      case TaskGroup.other:
        return s.other;
    }
  }
}
