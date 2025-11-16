import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTask {
  UpdateTask(this._repo);
  final TaskRepository _repo;
  Future<void> call(int key, Task task) => _repo.updateTask(key, task);
}

