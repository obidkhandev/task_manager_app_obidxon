import 'package:flutter/material.dart';

import '../models/task.dart';
import '../theme/app_colors.dart';
import '../models/task_extensions.dart';

class InProgressScroller extends StatelessWidget {
  const InProgressScroller({
    super.key,
    required this.tasks,
    required this.onTap,
  });

  final List<(int, Task)> tasks;
  final void Function((int, Task) entry) onTap;

  @override
  Widget build(BuildContext context) {
    final items = tasks.where((e) => e.$2.status != TaskStatus.done).toList();
    if (items.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final entry = items[index];
          return _InProgressCard(
            entry: entry,
            onTap: () => onTap(entry),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: items.length,
      ),
    );
  }
}

class _InProgressCard extends StatelessWidget {
  const _InProgressCard({required this.entry, required this.onTap});
  final (int, Task) entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = entry.$2;
    final double progress = _computeProgress(t);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F2FF), // light blue background
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(t.group.label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ),
                _categoryIcon(t.group),
              ],
            ),
            // const SizedBox(height: 8),
            Text(
              t.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress.clamp(0.0, 1.0)),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: Colors.white,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  double _computeProgress(Task t) {
    if (t.status == TaskStatus.done) return 1;
    if (t.startDate != null && t.endDate != null && t.endDate!.isAfter(t.startDate!)) {
      final total = t.endDate!.difference(t.startDate!).inSeconds;
      final done = DateTime.now().difference(t.startDate!).inSeconds;
      final p = done / total;
      return p.clamp(0.0, 1.0);
    }
    return 0.7; // default sample progress
  }

  Widget _categoryIcon(TaskGroup group) {
    return CircleAvatar(radius: 14, backgroundColor: group.color, child: Icon(group.icon, size: 16, color: Colors.white));
  }
}
