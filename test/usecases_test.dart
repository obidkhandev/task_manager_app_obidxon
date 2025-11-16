import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/core/utils/enums.dart';
import 'package:task_manager/features/task_management/domain/repositories/task_repository.dart';
import 'package:task_manager/features/task_management/domain/usecases/get_all_tasks.dart';
import 'package:task_manager/features/task_management/domain/usecases/get_tasks_by_category.dart';
import 'package:task_manager/features/task_management/domain/usecases/add_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/update_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/delete_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/toggle_task_completion.dart';

class _MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late _MockTaskRepository repo;

  setUp(() {
    repo = _MockTaskRepository();
  });

  setUpAll(() {
    // Needed by mocktail when using any<Task>() for non-nullable parameters
    registerFallbackValue(Task(title: 'fallback'));
  });

  test('GetAllTasks returns repository result', () async {
    final usecase = GetAllTasks(repo);
    when(() => repo.getAllTasks()).thenAnswer((_) async => <(int, Task)>[(1, Task(title: 'A'))]);

    final res = await usecase();
    expect(res, isA<List<(int, Task)>>());
    expect(res.single.$1, 1);
    expect(res.single.$2.title, 'A');
    verify(() => repo.getAllTasks()).called(1);
  });

  test('GetTasksByCategory forwards call to repository', () async {
    final usecase = GetTasksByCategory(repo);
    when(() => repo.getTasksByCategory(TaskGroup.work)).thenAnswer((_) async => <(int, Task)>[]);

    final res = await usecase(TaskGroup.work);
    expect(res, isEmpty);
    verify(() => repo.getTasksByCategory(TaskGroup.work)).called(1);
  });

  test('AddTask forwards to repository and returns key', () async {
    final usecase = AddTask(repo);
    when(() => repo.addTask(any<Task>())).thenAnswer((_) async => 42);

    final key = await usecase(Task(title: 'New'));
    expect(key, 42);
    verify(() => repo.addTask(any<Task>())).called(1);
  });

  test('UpdateTask forwards to repository', () async {
    final usecase = UpdateTask(repo);
    when(() => repo.updateTask(any<int>(), any<Task>())).thenAnswer((_) async {});

    await usecase(1, Task(title: 'U'));
    verify(() => repo.updateTask(1, any<Task>())).called(1);
  });

  test('DeleteTask forwards to repository', () async {
    final usecase = DeleteTask(repo);
    when(() => repo.deleteTask(any<int>())).thenAnswer((_) async {});

    await usecase(7);
    verify(() => repo.deleteTask(7)).called(1);
  });

  test('ToggleTaskCompletion forwards to repository', () async {
    final usecase = ToggleTaskCompletion(repo);
    when(() => repo.toggleTaskCompletion(any<int>(), any<bool>())).thenAnswer((_) async {});

    await usecase(2, true);
    verify(() => repo.toggleTaskCompletion(2, true)).called(1);
  });
}
