import '../../../../core/utils/enums.dart';

class Task {
  Task({
    required this.title,
    this.description,
    this.priority = Priority.medium,
    this.isCompleted = false,
    this.status = TaskStatus.todo,
    this.startDate,
    this.endDate,
    this.group = TaskGroup.work,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String title;
  final String? description;
  final Priority priority;
  final bool isCompleted;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final TaskGroup group;

  Task copyWith({
    String? title,
    String? description,
    Priority? priority,
    bool? isCompleted,
    TaskStatus? status,
    DateTime? createdAt,
    DateTime? startDate,
    DateTime? endDate,
    TaskGroup? group,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      group: group ?? this.group,
    );
  }
}

// enums are defined in priority.dart
