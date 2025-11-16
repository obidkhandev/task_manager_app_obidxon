import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/task.dart';
import '../../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_all_tasks.dart';
import '../../../domain/usecases/add_task.dart';
import '../../../domain/usecases/update_task.dart';
import '../../../domain/usecases/delete_task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({
    required GetAllTasks getAllTasks,
    required AddTask addTask,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
  })  : _getAllTasks = getAllTasks,
        _addTask = addTask,
        _updateTask = updateTask,
        _deleteTask = deleteTask,
        super(const TaskState()) {
    on<TasksRequested>(_onTasksRequested);
    on<AddTaskRequested>(_onAddTaskRequested);
    on<UpdateTaskRequested>(_onUpdateTaskRequested);
    on<DeleteTaskRequested>(_onDeleteTaskRequested);
    on<ToggleCompleteRequested>(_onToggleCompleteRequested);
    on<ChangeStatusRequested>(_onChangeStatusRequested);
  }
  final GetAllTasks _getAllTasks;
  final AddTask _addTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;

  Future<void> _onTasksRequested(
    TasksRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskListStatus.loading));
    try {
      final tasks = await _getAllTasks();
      emit(state.copyWith(status: TaskListStatus.success, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(status: TaskListStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onAddTaskRequested(
    AddTaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _addTask(
        Task(
          title: event.title,
          description: event.description?.trim().isEmpty == true
              ? null
              : event.description,
          priority: event.priority,
          startDate: event.startDate,
          endDate: event.endDate,
          group: event.group,
          isCompleted: event.isCompleted,
          status: event.status,
        ),
      );
      add(const TasksRequested());
    } catch (e) {
      emit(state.copyWith(status: TaskListStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onUpdateTaskRequested(
    UpdateTaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _updateTask(event.key, event.updated);
      add(const TasksRequested());
    } catch (e) {
      emit(state.copyWith(status: TaskListStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onDeleteTaskRequested(
    DeleteTaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _deleteTask(event.key);
      add(const TasksRequested());
    } catch (e) {
      emit(state.copyWith(status: TaskListStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onToggleCompleteRequested(
    ToggleCompleteRequested event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final list = state.tasks;
      final idx = list.indexWhere((e) => e.$1 == event.key);
      if (idx == -1) return;
      final current = list[idx].$2;
      final updated = current.copyWith(
        isCompleted: event.isCompleted,
        status: event.isCompleted ? TaskStatus.done : TaskStatus.todo,
      );
      await _updateTask(event.key, updated);
      add(const TasksRequested());
    } catch (e) {
      emit(state.copyWith(status: TaskListStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onChangeStatusRequested(
    ChangeStatusRequested event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final list = state.tasks;
      final idx = list.indexWhere((e) => e.$1 == event.key);
      if (idx == -1) return;
      final current = list[idx].$2;
      final updated = current.copyWith(
        status: event.status,
        isCompleted: event.status == TaskStatus.done,
      );
      await _updateTask(event.key, updated);
      add(const TasksRequested());
    } catch (e) {
      emit(state.copyWith(status: TaskListStatus.failure, error: e.toString()));
    }
  }
}
