import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils/enums.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';

import 'package:task_manager/features/task_management/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/widgets/fancy_task_card.dart';
import 'package:task_manager/features/task_management/presentation/widgets/swipe_to_delete_background.dart';
import 'package:task_manager/generated/l10n.dart';
import 'task_view_screen.dart';

class GroupTasksScreen extends StatefulWidget {
  const GroupTasksScreen({super.key, required this.group});

  final TaskGroup group;

  @override
  State<GroupTasksScreen> createState() => _GroupTasksScreenState();
}

enum _Filter { all, todo, inProgress, done }

class _GroupTasksScreenState extends State<GroupTasksScreen> {
  _Filter _filter = _Filter.all;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_groupLabel(context, widget.group))),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.status == TaskListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          final all = state.tasks.where((e) => e.$2.group == widget.group).toList();
          final filtered = _applyFilter(all);
          return Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _query = v.trim()),
                  decoration: InputDecoration(
                    hintText: S.of(context).tasks,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            tooltip: S.of(context).clear,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _StatusFilterBar(
                value: _filter,
                onChanged: (f) => setState(() => _filter = f),
              ),
              const SizedBox(height: 12),
              if (filtered.isEmpty)
                Expanded(child: Center(child: Text(S.of(context).noTasksYet)))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final entry = filtered[index];
                      return Dismissible(
                        key: ValueKey(entry.$1),
                        direction: DismissDirection.endToStart,
                        background: const SwipeToDeleteBackground(alignment: Alignment.centerLeft),
                        secondaryBackground:
                            const SwipeToDeleteBackground(alignment: Alignment.centerRight),
                        onDismissed: (_) => context.read<TaskBloc>().add(DeleteTaskRequested(entry.$1)),
                        child: FancyTaskCard(
                          entry: entry,
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => TaskViewScreen(entry: entry)),
                            );
                          },
                          onDelete: () => context.read<TaskBloc>().add(DeleteTaskRequested(entry.$1)),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
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

  List<(int, Task)> _applyFilter(List<(int, Task)> items) {
    // Apply status filter first
    Iterable<(int, Task)> filtered;
    switch (_filter) {
      case _Filter.all:
        filtered = items;
        break;
      case _Filter.todo:
        filtered = items.where((e) => e.$2.status == TaskStatus.todo);
        break;
      case _Filter.inProgress:
        filtered = items.where((e) => e.$2.status == TaskStatus.inProgress);
        break;
      case _Filter.done:
        filtered = items.where((e) => e.$2.status == TaskStatus.done);
        break;
    }

    // Apply text search on title/description
    final q = _query.toLowerCase();
    if (q.isEmpty) return filtered.toList();
    return filtered
        .where((e) {
          final t = e.$2;
          if (t.title.toLowerCase().contains(q)) return true;
          final d = t.description?.toLowerCase() ?? '';
          return d.contains(q);
        })
        .toList();
  }
}

class _StatusFilterBar extends StatelessWidget {
  const _StatusFilterBar({required this.value, required this.onChanged});
  final _Filter value;
  final ValueChanged<_Filter> onChanged;

  @override
  Widget build(BuildContext context) {
    const selectedBg = Color(0xFF5F33E1);
    const unselectedBg = Color(0xFFEDE8FF);
    const selectedFg = Colors.white;
    const unselectedFg = Color(0xFF5F33E1);

    Widget pill(String label, _Filter me) {
      final isSelected = value == me;
      return InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onChanged(me),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? selectedBg : unselectedBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? selectedFg : unselectedFg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          pill(S.of(context).all, _Filter.all),
          const SizedBox(width: 8),
          pill(S.of(context).toDo, _Filter.todo),
          const SizedBox(width: 8),
          pill(S.of(context).inProgress, _Filter.inProgress),
          const SizedBox(width: 8),
          pill(S.of(context).completed, _Filter.done),
        ],
      ),
    );
  }
}
