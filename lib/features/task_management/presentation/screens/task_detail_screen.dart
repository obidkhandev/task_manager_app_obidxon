import 'package:flutter/material.dart';
import '../../../../screens/task_view_screen.dart' as legacy;
import '../../domain/entities/task.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.entry});
  final (int, Task) entry;
  @override
  Widget build(BuildContext context) => legacy.TaskViewScreen(entry: entry);
}
