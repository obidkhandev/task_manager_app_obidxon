import '../entities/task.dart';
import '../repositories/task_repository.dart';

class AddTask {
  AddTask(this._repo);
  final TaskRepository _repo;
  Future<int> call(Task task) => _repo.addTask(task);
}

