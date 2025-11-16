import 'package:get_it/get_it.dart';

import 'features/task_management/data/datasources/task_local_datasource.dart';
import 'features/task_management/data/repositories/task_repository_impl.dart';
import 'features/task_management/domain/repositories/task_repository.dart';
import 'features/task_management/domain/usecases/get_all_tasks.dart';
import 'features/task_management/domain/usecases/add_task.dart';
import 'features/task_management/domain/usecases/update_task.dart';
import 'features/task_management/domain/usecases/delete_task.dart';
import 'services/settings_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data sources
  sl.registerSingletonAsync<TaskLocalDataSource>(() async {
    final ds = TaskLocalDataSource();
    await ds.init();
    return ds;
  });

  // Settings service
  sl.registerSingletonAsync<SettingsService>(() async {
    final s = SettingsService();
    await s.init();
    return s;
  });

  // Repository
  sl.registerSingletonWithDependencies<TaskRepository>(
    () => TaskRepositoryImpl(sl<TaskLocalDataSource>()),
    dependsOn: [TaskLocalDataSource],
  );

  // Use cases
  sl.registerFactory<GetAllTasks>(() => GetAllTasks(sl<TaskRepository>()));
  sl.registerFactory<AddTask>(() => AddTask(sl<TaskRepository>()));
  sl.registerFactory<UpdateTask>(() => UpdateTask(sl<TaskRepository>()));
  sl.registerFactory<DeleteTask>(() => DeleteTask(sl<TaskRepository>()));

  await sl.allReady();
}

