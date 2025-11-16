import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/utils/enums.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';
import 'package:task_manager/generated/l10n.dart';
import 'package:task_manager/core/theme/app_colors.dart';



typedef ToggleComplete = void Function(bool value);

class FancyTaskCard extends StatefulWidget {
  const FancyTaskCard({
    super.key,
    required this.entry,
    required this.onTap,
    required this.onDelete,
  });

  final (int, Task) entry;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  

  @override
  State<FancyTaskCard> createState() => _FancyTaskCardState();
}

class _FancyTaskCardState extends State<FancyTaskCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final task = widget.entry.$2;
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapCancel: () => setState(() => _scale = 1),
      onTapUp: (_) => setState(() => _scale = 1),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: _gradientDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _groupLabel(context, task.group),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
                    ),
                  ),
                  _categoryIcon(task.group),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                task.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              _timeBadge(task),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _priorityBadge(task.priority),
                  const SizedBox(width: 8),
                  _statusBadge(task),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _gradientDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      // gradient: const LinearGradient(
      //   begin: Alignment.topLeft,
      //   end: Alignment.bottomRight,
      //   colors: [
      //     // Color(0xFFFFF6D5), // subtle yellow
      //     // Color(0xFFFFE6F3), // subtle pink
      //     // Color(0xFFE6F7FF), // subtle blue
      //   ],
      //
      // ),
      color: AppColors.white,
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4)),
      ],
    );
  }

  Widget _timeBadge(Task t) {
    String label;
    if (t.startDate != null && t.endDate != null) {
      final sDate = t.startDate!;
      final eDate = t.endDate!;
      if (_sameDay(sDate, eDate)) {
        final day = DateFormat.yMMMd().format(sDate);
        final s = DateFormat.Hm().format(sDate);
        final e = DateFormat.Hm().format(eDate);
        label = '$day, $s - $e';
      } else {
        final s = DateFormat.yMMMd().add_Hm().format(sDate);
        final e = DateFormat.yMMMd().add_Hm().format(eDate);
        label = '$s → $e';
      }
    } else if (t.startDate != null) {
      label = DateFormat.yMMMd().add_Hm().format(t.startDate!);
    } else if (t.endDate != null) {
      label = DateFormat.yMMMd().add_Hm().format(t.endDate!);
    } else {
      label = DateFormat.yMMMd().add_Hm().format(t.createdAt);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _priorityBadge(Priority p) {
    final s = S.of(context);
    late final String label;
    late final Color bg;
    late final Color fg;
    switch (p) {
      case Priority.low:
        label = s.low;
        bg = const Color(0xFFE8F5E9); // green 50
        fg = const Color(0xFF2E7D32); // green 800
        break;
      case Priority.medium:
        label = s.medium;
        bg = const Color(0xFFFFF3E0); // orange 50
        fg = const Color(0xFFB05A00); // deep orange-ish
        break;
      case Priority.high:
        label = s.high;
        bg = const Color(0xFFFFEBEE); // red 50
        fg = const Color(0xFFC62828); // red 800
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.flag_outlined, size: 16, color: fg),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _statusBadge(Task t) {
    final (bg, text, label) = _statusStyle(context, t);
    return Align(
      alignment: Alignment.bottomLeft,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Text(label, style: TextStyle(color: text, fontWeight: FontWeight.w600)),
      ),
    );
  }

  (Color, Color, String) _statusStyle(BuildContext context, Task t) {
    final s = S.of(context);
    switch (t.status) {
      case TaskStatus.done:
        return (AppColors.statusDoneBg, AppColors.primary, s.doneStatus);
      case TaskStatus.inProgress:
        return (AppColors.statusInProgressBg, const Color(0xFFB05A00), s.inProgress);
      case TaskStatus.todo:
        return (AppColors.statusTodoBg, const Color(0xFF0D47A1), s.toDo);
    }
  }

  Widget _categoryIcon(TaskGroup group) {
    final (color, icon) = switch (group) {
      TaskGroup.work => (AppColors.categoryPurple, Icons.work_outline),
      TaskGroup.study => (AppColors.categoryPink, Icons.school_outlined),
      TaskGroup.gym => (AppColors.categoryOrange, Icons.fitness_center),
      TaskGroup.personal => (AppColors.categoryTeal, Icons.person_outline),
      TaskGroup.other => (AppColors.categoryGrey, Icons.category_outlined),
    };
    return CircleAvatar(
      backgroundColor: color,
      radius: 16,
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

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
