import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/theme/app_colors.dart';


class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onSelected,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    // Build a 5-day range centered on today: today-2 .. today+2
    final start = DateTime(today.year, today.month, today.day).subtract(const Duration(days: 2));
    final days = List.generate(5, (i) => start.add(Duration(days: i)));

    return SizedBox(
      height: 76,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final d = days[index];
          final isSelected = _isSameDay(d, selectedDate);
          final isToday = _isSameDay(d, today);
          return _DatePill(
            date: d,
            isSelected: isSelected,
            isToday: isToday,
            onTap: () => onSelected(d),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: days.length,
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
}

class _DatePill extends StatelessWidget {
  const _DatePill({
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final month = DateFormat.MMM().format(date);
    final day = date.day.toString();
    final color = isSelected ? Colors.white : Colors.black87;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : (isToday ? AppColors.statusTodoBg : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppColors.primary : const Color(0xFFE6E8EC)),
          boxShadow: [
            if (isSelected)
              BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(month, style: TextStyle(fontSize: 12, color: color)),
            const SizedBox(height: 2),
            Text(day, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
