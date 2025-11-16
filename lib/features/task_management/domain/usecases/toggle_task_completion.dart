import '../repositories/task_repository.dart';

class ToggleTaskCompletion {
  ToggleTaskCompletion(this._repo);
  final TaskRepository _repo;
  Future<void> call(int key, bool isCompleted) => _repo.toggleTaskCompletion(key, isCompleted);
}

