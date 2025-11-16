import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils/enums.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/generated/l10n.dart';
import 'settings_screen.dart';

import 'package:task_manager/features/task_management/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/widgets/custom_toast.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/task_management/presentation/widgets/top_progress_card.dart';
import 'package:task_manager/features/task_management/presentation/widgets/in_progress_scroller.dart';
import 'package:task_manager/features/task_management/presentation/widgets/group_summary_card.dart';
import 'package:task_manager/features/task_management/presentation/widgets/section_header.dart';
import 'package:task_manager/features/task_management/presentation/widgets/empty_state.dart';
import 'package:task_manager/features/task_management/presentation/widgets/animated_fab.dart';
import 'group_tasks_screen.dart';
import 'task_edit/task_new_edit_screen.dart';
import 'task_view_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // removed date filter and tabs; show all tasks
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(const TasksRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        actions: [
          IconButton(
            tooltip: S.of(context).settings,
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          )
        ],
      ),
      backgroundColor: AppColors.background,
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state.status == TaskListStatus.failure && state.error != null) {
            CustomToast.showError(context, state.error!);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case TaskListStatus.initial:
            case TaskListStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case TaskListStatus.failure:
              return Center(child: Text(state.error ?? S.of(context).somethingWentWrong));
            case TaskListStatus.success:
              final tasks = state.tasks;
              final completed = tasks.where((e) => e.$2.status == TaskStatus.done).length;
              final percent = tasks.isEmpty ? 0.0 : completed / tasks.length;
              final inProgress = tasks.where((e) => e.$2.status == TaskStatus.inProgress).toList();
              // Group summaries
              final byGroup = <TaskGroup, List<(int, Task)>>{};
              for (final e in tasks) {
                byGroup.putIfAbsent(e.$2.group, () => []).add(e);
              }
              final groups = byGroup.entries.toList();

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: TopProgressCard(percent: percent, onViewTasks: () {}),
                  ),
                  SliverToBoxAdapter(child: SectionHeader(title: S.of(context).inProgress, count: inProgress.length)),
                  SliverToBoxAdapter(
                    child: InProgressScroller(
                      tasks: inProgress,
                      onTap: (entry) async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => TaskViewScreen(entry: entry)),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SectionHeader(title: S.of(context).allTasks, count: tasks.length, padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12)),
                  ),
                  if (tasks.isEmpty)
                    const SliverToBoxAdapter(child: EmptyState())
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final entry = groups[index];
                          return GroupSummaryCard(
                            group: entry.key,
                            total: entry.value.length,
                            completed: entry.value.where((e) => e.$2.status == TaskStatus.done).length,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => GroupTasksScreen(group: entry.key),
                                ),
                              );
                            },
                          );
                        },
                        childCount: groups.length,
                      ),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 80)),
                ],
              );
          }
        },
      ),
      floatingActionButton: AnimatedFab(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const TaskNewEditScreen(),
            ),
          );
          if (result == 'added') {
            CustomToast.showSuccess(context, S.of(context).taskAdded);
          }
        },
      ),
    );
  }


}
