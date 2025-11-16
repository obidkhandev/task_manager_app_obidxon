import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../generated/l10n.dart';
import 'circular_percent.dart';

class TopProgressCard extends StatelessWidget {
  const TopProgressCard({
    super.key,
    required this.percent, // 0..1
    this.onViewTasks,
  });

  final double percent;
  final VoidCallback? onViewTasks;

  @override
  Widget build(BuildContext context) {
    final p = (percent.clamp(0.0, 1.0) * 100).round();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFF7E6AF3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${S.of(context).yourTodaysTask} ${S.of(context).almostDone}",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircularPercent(percent: percent, label: '$p%'),
        ],
      ),
    );
  }
}
