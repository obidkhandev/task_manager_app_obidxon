import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../models/task.dart';
import '../../../models/task_extensions.dart';

class StatusPicker extends StatelessWidget {
  const StatusPicker({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 6),
        DropdownButtonHideUnderline(
          child: DropdownButton2<TaskStatus>(
            isExpanded: true,
            value: value,
            items: TaskStatus.values
                .map((e) => DropdownMenuItem<TaskStatus>(value: e, child: Text(e.label)))
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
}

