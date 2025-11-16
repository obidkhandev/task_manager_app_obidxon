import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:task_manager/features/task_management/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager/features/task_management/domain/usecases/get_all_tasks.dart';
import 'package:task_manager/features/task_management/domain/usecases/add_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/update_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/delete_task.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/core/utils/enums.dart';

class _MockGetAllTasks extends Mock implements GetAllTasks {}
class _MockAddTask extends Mock implements AddTask {}
class _MockUpdateTask extends Mock implements UpdateTask {}
class _MockDeleteTask extends Mock implements DeleteTask {}

void main() {
  late _MockGetAllTasks getAllTasks;
  late _MockAddTask addTask;
  late _MockUpdateTask updateTask;
  late _MockDeleteTask deleteTask;
  late TaskBloc bloc;

  setUpAll(() {
    // Register a fallback for non-nullable Task when using any<Task>() in mocktail
    registerFallbackValue(Task(title: 'fallback'));
  });

  setUp(() {
    getAllTasks = _MockGetAllTasks();
    addTask = _MockAddTask();
    updateTask = _MockUpdateTask();
    deleteTask = _MockDeleteTask();
    bloc = TaskBloc(
      getAllTasks: getAllTasks,
      addTask: addTask,
      updateTask: updateTask,
      deleteTask: deleteTask,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  test('initial state is TaskState.initial', () {
    expect(bloc.state.status, TaskListStatus.initial);
    expect(bloc.state.tasks, isEmpty);
  });

  blocTest<TaskBloc, TaskState>(
    'emits [loading, success] when TasksRequested succeeds',
    build: () {
      when(() => getAllTasks()).thenAnswer((_) async => <(int, Task)>[]);
      return bloc;
    },
    act: (b) => b.add(const TasksRequested()),
    expect: () => [
      const TaskState(status: TaskListStatus.loading, tasks: []),
      const TaskState(status: TaskListStatus.success, tasks: []),
    ],
  );

  blocTest<TaskBloc, TaskState>(
    'calls addTask and then getAllTasks on AddTaskRequested',
    build: () {
      when(() => addTask(any<Task>())).thenAnswer((_) async => 1);
      when(() => getAllTasks()).thenAnswer((_) async => <(int, Task)>[]);
      return bloc;
    },
    act: (b) => b.add(const AddTaskRequested(title: 'A', description: null, priority: Priority.medium)),
    verify: (b) {
      verify(() => addTask(any<Task>())).called(1);
      verify(() => getAllTasks()).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'calls updateTask then getAllTasks on UpdateTaskRequested',
    build: () {
      when(() => updateTask(any<int>(), any<Task>())).thenAnswer((_) async {});
      when(() => getAllTasks()).thenAnswer((_) async => <(int, Task)>[]);
      return bloc;
    },
    act: (b) {
      final updated = Task(title: 'Updated');
      b.add(UpdateTaskRequested(key: 1, updated: updated));
    },
    verify: (b) {
      verify(() => updateTask(1, any<Task>())).called(1);
      verify(() => getAllTasks()).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'calls deleteTask then getAllTasks on DeleteTaskRequested',
    build: () {
      when(() => deleteTask(any<int>())).thenAnswer((_) async {});
      when(() => getAllTasks()).thenAnswer((_) async => <(int, Task)>[]);
      return bloc;
    },
    act: (b) => b.add(const DeleteTaskRequested(1)),
    verify: (b) {
      verify(() => deleteTask(1)).called(1);
      verify(() => getAllTasks()).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'ToggleCompleteRequested updates task completion and refreshes list',
    build: () {
      when(() => updateTask(any<int>(), any<Task>())).thenAnswer((_) async {});
      when(() => getAllTasks()).thenAnswer((_) async => <(int, Task)>[]);
      return bloc;
    },
    seed: () => TaskState(
      status: TaskListStatus.success,
      tasks: [
        (1, Task(title: 'A', isCompleted: false, status: TaskStatus.todo)),
      ],
    ),
    act: (b) => b.add(const ToggleCompleteRequested(key: 1, isCompleted: true)),
    verify: (b) {
      verify(
        () => updateTask(
          1,
          any<Task>(
            that: isA<Task>()
                .having((t) => t.isCompleted, 'isCompleted', true)
                .having((t) => t.status, 'status', TaskStatus.done),
          ),
        ),
      ).called(1);
      verify(() => getAllTasks()).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'ChangeStatusRequested updates status and refreshes list',
    build: () {
      when(() => updateTask(any<int>(), any<Task>())).thenAnswer((_) async {});
      when(() => getAllTasks()).thenAnswer((_) async => <(int, Task)>[]);
      return bloc;
    },
    seed: () => TaskState(
      status: TaskListStatus.success,
      tasks: [
        (2, Task(title: 'B', isCompleted: false, status: TaskStatus.todo)),
      ],
    ),
    act: (b) => b.add(const ChangeStatusRequested(key: 2, status: TaskStatus.inProgress)),
    verify: (b) {
      verify(
        () => updateTask(
          2,
          any<Task>(
            that: isA<Task>()
                .having((t) => t.status, 'status', TaskStatus.inProgress)
                .having((t) => t.isCompleted, 'isCompleted', false),
          ),
        ),
      ).called(1);
      verify(() => getAllTasks()).called(1);
    },
  );
}
