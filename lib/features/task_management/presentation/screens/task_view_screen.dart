import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/utils/enums.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';

import 'package:task_manager/features/task_management/presentation/bloc/task/task_bloc.dart';
import 'task_edit/task_new_edit_screen.dart';
import 'package:task_manager/theme/app_colors.dart';
import 'package:task_manager/features/task_management/presentation/widgets/slide_fade_in.dart';
import 'package:task_manager/features/task_management/presentation/widgets/circular_percent.dart';
import 'task_edit/widgets/status_chip_picker.dart';
import 'task_edit/widgets/priority_chip_picker.dart';
import 'task_edit/widgets/group_chip_picker.dart';
import 'task_edit/widgets/date_time_field.dart';
import 'package:task_manager/features/task_management/presentation/widgets/quick_action_chip.dart';
import 'package:task_manager/generated/l10n.dart';
import 'group_tasks_screen.dart';
// Removed localization for simplicity

class TaskViewScreen extends StatelessWidget {
  const TaskViewScreen({super.key, required this.entry});

  final (int, Task) entry;

  @override
  Widget build(BuildContext context) {
    final keyId = entry.$1;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).taskDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: S.of(context).edit,
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TaskNewEditScreen(entry: entry),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: S.of(context).delete,
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(S.of(context).deleteTask),
                  content: Text(S.of(context).confirmDeleteTask),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(S.of(context).cancel),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(S.of(context).delete),
                    )
                  ],
                ),
              );
              if (confirm == true) {
                context.read<TaskBloc>().add(DeleteTaskRequested(keyId));
                Navigator.of(context).pop('deleted');
              }
            },
          )
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          final entry = state.tasks.where((e) => e.$1 == keyId).toList();
          if (entry.isEmpty) {
            return const Center(child: Text('Task not found'));
          }
          final task = entry.first.$2;
          final created = DateFormat.yMMMd().add_Hm().format(task.createdAt);

          double percent = 0;
          if (task.status == TaskStatus.done) {
            percent = 1;
          } else if (task.startDate != null && task.endDate != null) {
            final now = DateTime.now();
            final total = task.endDate!.difference(task.startDate!).inSeconds;
            final elapsed = now.difference(task.startDate!).inSeconds;
            if (total <= 0) {
              percent = 0;
            } else {
              percent = (elapsed / total).clamp(0, 1).toDouble();
            }
          }
          final percentLabel = task.status == TaskStatus.done
              ? 'Done'
              : '${(percent * 100).round()}%';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SlideFadeIn(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => GroupTasksScreen(group: task.group),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.folder_outlined, size: 18, color: AppColors.grey),
                                  const SizedBox(width: 6),
                                  Text('Group: ${_groupLabel(context, task.group)}',
                                      style: const TextStyle(color: Colors.black87)),
                                  const Icon(Icons.chevron_right, size: 18, color: AppColors.grey),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(S.of(context).created(created), style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircularPercent(
                        percent: percent,
                        label: task.status == TaskStatus.done ? S.of(context).doneLabel : percentLabel,
                        size: 84,
                        strokeWidth: 7,
                        progressColor: AppColors.primary,
                        trackColor: Colors.black12,
                        backgroundCircleColor: Colors.black12,
                        labelStyle: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SlideFadeIn(
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).status),
                          const SizedBox(height: 8),
                          StatusChipPicker(
                            value: task.status,
                            onChanged: (s) {
                              context
                                  .read<TaskBloc>()
                                  .add(ChangeStatusRequested(key: keyId, status: s));
                            },
                          ),
                          const SizedBox(height: 12),
                          Text(S.of(context).priority),
                          const SizedBox(height: 8),
                          PriorityChipPicker(
                            value: task.priority,
                            onChanged: (p) {
                              context.read<TaskBloc>().add(
                                    UpdateTaskRequested(
                                      key: keyId,
                                      updated: task.copyWith(priority: p),
                                    ),
                                  );
                            },
                          ),
                          const SizedBox(height: 12),
                          Text(S.of(context).group),
                          const SizedBox(height: 8),
                          GroupChipPicker(
                            value: task.group,
                            onChanged: (g) {
                              context.read<TaskBloc>().add(
                                    UpdateTaskRequested(
                                      key: keyId,
                                      updated: task.copyWith(group: g),
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SlideFadeIn(
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).schedule),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: DateTimeField(
                                  label: S.of(context).startDateTime,
                                  value: task.startDate,
                                  onPick: () async {
                                    final picked = await pickDateTime(context, task.startDate);
                                    if (picked != null) {
                                      // ignore: use_build_context_synchronously
                                      context.read<TaskBloc>().add(
                                            UpdateTaskRequested(
                                              key: keyId,
                                              updated: task.copyWith(startDate: picked),
                                            ),
                                          );
                                    }
                                  },
                                  onClear: () {
                                    context.read<TaskBloc>().add(
                                          UpdateTaskRequested(
                                            key: keyId,
                                            updated: task.copyWith(startDate: null),
                                          ),
                                        );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DateTimeField(
                                  label: S.of(context).endDateTime,
                                  value: task.endDate,
                                  onPick: () async {
                                    final picked = await pickDateTime(context, task.endDate ?? task.startDate);
                                    if (picked != null) {
                                      // ignore: use_build_context_synchronously
                                      context.read<TaskBloc>().add(
                                            UpdateTaskRequested(
                                              key: keyId,
                                              updated: task.copyWith(endDate: picked),
                                            ),
                                          );
                                    }
                                  },
                                  onClear: () {
                                    context.read<TaskBloc>().add(
                                          UpdateTaskRequested(
                                            key: keyId,
                                            updated: task.copyWith(endDate: null),
                                          ),
                                        );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                QuickActionChip(
                                  label: S.of(context).startNow,
                                  onTap: () => context.read<TaskBloc>().add(
                                        UpdateTaskRequested(
                                          key: keyId,
                                          updated: task.copyWith(startDate: DateTime.now()),
                                        ),
                                      ),
                                ),
                                const SizedBox(width: 8),
                                QuickActionChip(
                                  label: S.of(context).plus30mEnd,
                                  onTap: () {
                                    final base = task.startDate ?? DateTime.now();
                                    context.read<TaskBloc>().add(
                                          UpdateTaskRequested(
                                            key: keyId,
                                            updated: task.copyWith(endDate: base.add(const Duration(minutes: 30))),
                                          ),
                                        );
                                  },
                                ),
                                const SizedBox(width: 8),
                                QuickActionChip(
                                  label: S.of(context).plus1hEnd,
                                  onTap: () {
                                    final base = task.startDate ?? DateTime.now();
                                    context.read<TaskBloc>().add(
                                          UpdateTaskRequested(
                                            key: keyId,
                                            updated: task.copyWith(endDate: base.add(const Duration(hours: 1))),
                                          ),
                                        );
                                  },
                                ),
                                const SizedBox(width: 8),
                                QuickActionChip(
                                  label: S.of(context).clearDates,
                                  onTap: () => context.read<TaskBloc>().add(
                                        UpdateTaskRequested(
                                          key: keyId,
                                          updated: task.copyWith(startDate: null, endDate: null),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SlideFadeIn(
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).description),
                          const SizedBox(height: 8),
                          Text(
                            task.description?.isNotEmpty == true
                                ? task.description!
                                : 'No description',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _BottomBar(entry: entry),
    );
  }

  String _groupLabel(BuildContext context, TaskGroup g) {
    final s = S.of(context);
    switch (g) {
      case TaskGroup.work:
        return s.work;
      case TaskGroup.study:
        return s.study;
      case TaskGroup.gym:
        return s.gym;
      case TaskGroup.personal:
        return s.personal;
      case TaskGroup.other:
        return s.other;
    }
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.entry});
  final (int, Task) entry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            final current = state.tasks.firstWhere(
              (e) => e.$1 == entry.$1,
              orElse: () => entry,
            );
            final task = current.$2;
            final isDone = task.status == TaskStatus.done;
            return Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TaskNewEditScreen(entry: (entry.$1, task)),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: Text(S.of(context).edit),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      final next = isDone ? TaskStatus.todo : TaskStatus.done;
                      context
                          .read<TaskBloc>()
                          .add(ChangeStatusRequested(key: entry.$1, status: next));
                    },
                    icon: Icon(isDone ? Icons.undo : Icons.check_circle),
                    label: Text(isDone ? S.of(context).markTodo : S.of(context).markDone),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
