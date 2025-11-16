import 'package:flutter/material.dart';
import 'package:task_manager/features/task_management/presentation/screens/task_edit/task_new_edit_screen.dart' as legacy;

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});
  @override
  Widget build(BuildContext context) => const legacy.TaskNewEditScreen();
}
