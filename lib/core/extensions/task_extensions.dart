import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/utils/enums.dart';

extension TaskGroupX on TaskGroup {
  String get label {
    switch (this) {
      case TaskGroup.work:
        return 'Work';
      case TaskGroup.study:
        return 'Study';
      case TaskGroup.gym:
        return 'Gym';
      case TaskGroup.personal:
        return 'Personal';
      case TaskGroup.other:
        return 'Other';
    }
  }

  Color get color {
    switch (this) {
      case TaskGroup.work:
        return AppColors.categoryPurple;
      case TaskGroup.study:
        return AppColors.categoryPink;
      case TaskGroup.gym:
        return AppColors.categoryOrange;
      case TaskGroup.personal:
        return AppColors.categoryTeal;
      case TaskGroup.other:
        return AppColors.categoryGrey;
    }
  }

  IconData get icon {
    switch (this) {
      case TaskGroup.work:
        return Icons.work_outline;
      case TaskGroup.study:
        return Icons.school_outlined;
      case TaskGroup.gym:
        return Icons.fitness_center;
      case TaskGroup.personal:
        return Icons.person_outline;
      case TaskGroup.other:
        return Icons.category_outlined;
    }
  }
}

extension TaskStatusX on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.todo:
        return 'To do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
    }
  }
}

extension PriorityX on Priority {
  String get label {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
    }
  }
}

