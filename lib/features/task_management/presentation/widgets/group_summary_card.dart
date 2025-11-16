import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/enums.dart';
import 'package:task_manager/features/task_management/data/models/task_extensions.dart';

// Removed localization for simplicity

class GroupSummaryCard extends StatelessWidget {
  const GroupSummaryCard({
    super.key,
    required this.group,
    required this.total,
    required this.completed,
    this.onTap,
  });

  final TaskGroup group;
  final int total;
  final int completed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0.0 : completed / total;
    final (color, icon) = _iconStyle(group);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 24, backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group.label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  const SizedBox(height: 2),
                  Text('$total Tasks', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ),
            SizedBox(
              width: 54,
              height: 54,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: percent.clamp(0.0, 1.0)),
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(backgroundColor: Colors.white, radius: 27),
                      SizedBox(
                        width: 54,
                        height: 54,
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                          value: value,
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                        ),
                      ),
                      Text('${(value * 100).round()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  (Color, IconData) _iconStyle(TaskGroup g) => (g.color, g.icon);

  String _groupLabel(TaskGroup g) => g.label;
}
