import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/utils/constants.dart';
import '../../domain/entities/task.dart' as domain show Task;
import '../../domain/entities/priority.dart';
import '../models/task_model.dart';

class TaskLocalDataSource {
  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(PriorityModelAdapter());
    if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(TaskGroupModelAdapter());
    if (!Hive.isAdapterRegistered(4)) Hive.registerAdapter(TaskStatusModelAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(TaskModelAdapter());
    if (!Hive.isBoxOpen(Constants.tasksBox)) {
      await Hive.openBox<TaskModel>(Constants.tasksBox);
    }
  }

  Box<TaskModel> get _box => Hive.box<TaskModel>(Constants.tasksBox);

  Future<List<MapEntry<int, domain.Task>>> fetchAll() async {
    final entries = _box.toMap().entries
        .map((e) => MapEntry(e.key as int, e.value.toDomain()))
        .toList()
      ..sort((a, b) => b.value.createdAt.compareTo(a.value.createdAt));
    return entries;
  }

  Future<List<MapEntry<int, domain.Task>>> fetchByGroup(TaskGroup group) async {
    final all = await fetchAll();
    return all.where((e) => e.value.group == group).toList();
  }

  Future<int> add(domain.Task task) async => _box.add(TaskModel.fromDomain(task));
  Future<void> put(int key, domain.Task task) async => _box.put(key, TaskModel.fromDomain(task));
  Future<void> delete(int key) async => _box.delete(key);
}
