import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetAllTasks {
  GetAllTasks(this._repo);
  final TaskRepository _repo;
  Future<List<(int, Task)>> call() => _repo.getAllTasks();
}

