import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_date_picker_bottom_sheet.dart';
import '../../../generated/l10n.dart';

class DateTimeField extends StatelessWidget {
  const DateTimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onPick,
    required this.onClear,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onPick;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final formatted = value == null ? S.of(context).notSet : DateFormat.yMMMd().add_Hm().format(value!);
    return InkWell(
      onTap: onPick,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: value != null
              ? IconButton(
                  tooltip: S.of(context).clear,
                  icon: const Icon(Icons.close),
                  onPressed: onClear,
                )
              : null,
        ),
        child: Text(formatted),
      ),
    );
  }
}

Future<DateTime?> pickDateTime(BuildContext context, DateTime? initial) async {
  return await CustomDatePickerBottomSheet.show(
    context: context,
    initialDate: initial ?? DateTime.now(),
  );
}
