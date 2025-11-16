import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:task_manager/features/task_management/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager/features/task_management/domain/usecases/get_all_tasks.dart';
import 'package:task_manager/features/task_management/domain/usecases/add_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/update_task.dart';
import 'package:task_manager/features/task_management/domain/usecases/delete_task.dart';
import 'package:task_manager/models/task.dart';

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
      when(() => addTask(any())).thenAnswer((_) async => 1);
      when(() => getAllTasks()).thenAnswer((_) async => <(int, Task)>[]);
      return bloc;
    },
    act: (b) => b.add(const AddTaskRequested(title: 'A', description: null, priority: Priority.medium)),
    verify: (b) {
      verify(() => addTask(any())).called(1);
      verify(() => getAllTasks()).called(1);
    },
  );
}
