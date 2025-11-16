import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/enums.dart';

import 'package:task_manager/features/task_management/data/models/task_extensions.dart';
import 'package:task_manager/generated/l10n.dart';
import 'package:task_manager/theme/app_colors.dart';

class GroupChipPicker extends StatelessWidget {
  const GroupChipPicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Group',
  });

  final TaskGroup value;
  final ValueChanged<TaskGroup> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    const groups = TaskGroup.values;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).group, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final g in groups)
              ChoiceChip(
                selected: value == g,
                onSelected: (_) => onChanged(g),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(g.icon, size: 16, color: value == g ? Colors.white : Colors.black54),
                    const SizedBox(width: 6),
                    Text(_label(context, g)),
                  ],
                ),
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(color: value == g ? Colors.white : Colors.black87),
                backgroundColor: AppColors.primary.withOpacity(0.12),
              ),
          ],
        ),
      ],
    );
  }

  String _label(BuildContext context, TaskGroup g) {
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
