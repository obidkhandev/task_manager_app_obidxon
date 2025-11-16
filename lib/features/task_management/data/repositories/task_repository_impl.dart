import '../../domain/entities/task.dart';
import 'package:task_manager/core/utils/enums.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this._ds);
  final TaskLocalDataSource _ds;

  @override
  Future<int> addTask(Task task) => _ds.add(task);

  @override
  Future<void> deleteTask(int key) => _ds.delete(key);

  @override
  Future<List<(int, Task)>> getAllTasks() async {
    final entries = await _ds.fetchAll();
    return entries.map((e) => (e.key, e.value)).toList();
  }

  @override
  Future<List<(int, Task)>> getTasksByCategory(TaskGroup group) async {
    final entries = await _ds.fetchByGroup(group);
    return entries.map((e) => (e.key, e.value)).toList();
  }

  @override
  Future<void> toggleTaskCompletion(int key, bool isCompleted) async {
    final all = await _ds.fetchAll();
    final entry = all.firstWhere((e) => e.key == key, orElse: () => throw StateError('Not found'));
    final updated = entry.value.copyWith(
      isCompleted: isCompleted,
      status: isCompleted ? TaskStatus.done : TaskStatus.todo,
    );
    await _ds.put(key, updated);
  }

  @override
  Future<void> updateTask(int key, Task task) => _ds.put(key, task);
}
