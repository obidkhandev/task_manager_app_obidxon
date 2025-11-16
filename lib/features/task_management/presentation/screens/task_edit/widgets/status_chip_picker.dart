import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/enums.dart';

import 'package:task_manager/generated/l10n.dart';
import 'package:task_manager/theme/app_colors.dart';

class StatusChipPicker extends StatelessWidget {
  const StatusChipPicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Status',
  });

  final TaskStatus value;
  final ValueChanged<TaskStatus> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    const statuses = TaskStatus.values;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).status, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final s in statuses)
              ChoiceChip(
                label: Text(_label(context, s)),
                selected: value == s,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(color: value == s ? Colors.white : Colors.black87),
                backgroundColor: AppColors.primary.withOpacity(0.12),
                onSelected: (_) => onChanged(s),
              ),
          ],
        ),
      ],
    );
  }

  String _label(BuildContext context, TaskStatus s) {
    final l = S.of(context);
    switch (s) {
      case TaskStatus.todo:
        return l.toDo;
      case TaskStatus.inProgress:
        return l.inProgress;
      case TaskStatus.done:
        return l.doneStatus;
    }
  }
}
