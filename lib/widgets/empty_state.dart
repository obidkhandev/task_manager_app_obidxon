import 'package:flutter/material.dart';
import 'package:task_manager/generated/l10n.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.checklist_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(S.of(context).noTasksYet, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(S.of(context).tapToAddFirstTask),
        ],
      ),
    );
  }
}
