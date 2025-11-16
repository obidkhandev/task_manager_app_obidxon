part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class TasksRequested extends TaskEvent {
  const TasksRequested();
}

class AddTaskRequested extends TaskEvent {
  const AddTaskRequested({
    required this.title,
    this.description,
    required this.priority,
    this.startDate,
    this.endDate,
    this.group = TaskGroup.work,
    this.isCompleted = false,
    this.status = TaskStatus.todo,
  });

  final String title;
  final String? description;
  final Priority priority;
  final DateTime? startDate;
  final DateTime? endDate;
  final TaskGroup group;
  final bool isCompleted;
  final TaskStatus status;

  @override
  List<Object?> get props => [title, description, priority, startDate, endDate, group, isCompleted, status];
}

class ChangeStatusRequested extends TaskEvent {
  const ChangeStatusRequested({required this.key, required this.status});
  final int key;
  final TaskStatus status;
  @override
  List<Object?> get props => [key, status];
}

class UpdateTaskRequested extends TaskEvent {
  const UpdateTaskRequested({required this.key, required this.updated});
  final int key;
  final Task updated;
  @override
  List<Object?> get props => [key, updated];
}

class DeleteTaskRequested extends TaskEvent {
  const DeleteTaskRequested(this.key);
  final int key;
  @override
  List<Object?> get props => [key];
}

class ToggleCompleteRequested extends TaskEvent {
  const ToggleCompleteRequested({required this.key, required this.isCompleted});
  final int key;
  final bool isCompleted;
  @override
  List<Object?> get props => [key, isCompleted];
}

