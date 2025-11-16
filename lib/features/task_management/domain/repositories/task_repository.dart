import '../entities/task.dart';
import '../entities/priority.dart';

abstract class TaskRepository {
  Future<List<(int, Task)>> getAllTasks();
  Future<List<(int, Task)>> getTasksByCategory(TaskGroup group);
  Future<int> addTask(Task task);
  Future<void> updateTask(int key, Task task);
  Future<void> deleteTask(int key);
  Future<void> toggleTaskCompletion(int key, bool isCompleted);
}
