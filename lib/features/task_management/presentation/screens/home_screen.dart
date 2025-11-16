import 'package:flutter/material.dart';
import '../../../../screens/task_list_screen.dart' as legacy;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const legacy.TaskListScreen();
}

