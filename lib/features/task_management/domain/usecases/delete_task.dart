import '../repositories/task_repository.dart';

class DeleteTask {
  DeleteTask(this._repo);
  final TaskRepository _repo;
  Future<void> call(int key) => _repo.deleteTask(key);
}

