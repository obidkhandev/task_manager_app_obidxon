import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/enums.dart';

import 'package:task_manager/theme/app_colors.dart';
import 'package:task_manager/generated/l10n.dart';

class PriorityChipPicker extends StatelessWidget {
  const PriorityChipPicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Priority',
  });

  final Priority value;
  final ValueChanged<Priority> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    const priorities = Priority.values;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).priority, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in priorities)
              ChoiceChip(
                label: Text(_label(context, p)),
                selected: value == p,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(color: value == p ? Colors.white : Colors.black87),
                backgroundColor: AppColors.primary.withOpacity(0.12),
                onSelected: (_) => onChanged(p),
              ),
          ],
        ),
      ],
    );
  }

  String _label(BuildContext context, Priority p) {
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
}
