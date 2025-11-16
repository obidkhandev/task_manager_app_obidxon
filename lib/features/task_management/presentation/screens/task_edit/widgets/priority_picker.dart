import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/enums.dart';

import 'package:task_manager/core/extensions/task_extensions.dart';
import 'package:task_manager/generated/l10n.dart';

class PriorityPicker extends StatelessWidget {
  const PriorityPicker({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).priority, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 6),
        DropdownButtonHideUnderline(
          child: DropdownButton2<Priority>(
            isExpanded: true,
            value: value,
            items: Priority.values
                .map((e) => DropdownMenuItem<Priority>(value: e, child: Text(_label(context, e))))
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
            buttonStyleData: ButtonStyleData(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF808080)),
                color: Colors.white,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
          ),
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
