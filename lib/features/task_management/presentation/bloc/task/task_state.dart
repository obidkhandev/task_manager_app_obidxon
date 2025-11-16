part of 'task_bloc.dart';

enum TaskListStatus { initial, loading, success, failure }

class TaskState extends Equatable {
  const TaskState({
    this.status = TaskListStatus.initial,
    this.tasks = const [],
    this.error,
  });

  final TaskListStatus status;
  final List<(int, Task)> tasks; // (key, task)
  final String? error;

  TaskState copyWith({
    TaskListStatus? status,
    List<(int, Task)>? tasks,
    String? error,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, tasks, error];
}

