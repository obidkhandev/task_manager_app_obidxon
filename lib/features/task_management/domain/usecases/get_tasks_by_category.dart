import '../entities/task.dart';
import '../../../../core/utils/enums.dart';
import '../repositories/task_repository.dart';

class GetTasksByCategory {
  GetTasksByCategory(this._repo);
  final TaskRepository _repo;
  Future<List<(int, Task)>> call(TaskGroup group) => _repo.getTasksByCategory(group);
}
