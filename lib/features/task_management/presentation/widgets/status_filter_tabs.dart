import 'package:flutter/material.dart';
import 'package:task_manager/generated/l10n.dart';
import 'package:task_manager/core/theme/app_colors.dart';


enum StatusFilter { all, todo, inProgress, completed }

class StatusFilterTabs extends StatelessWidget {
  const StatusFilterTabs({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final StatusFilter value;
  final ValueChanged<StatusFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _Tab(
            label: S.of(context).all,
            selected: value == StatusFilter.all,
            selectedColor: AppColors.primary,
            unselectedBg: AppColors.statusTodoBg,
            onTap: () => onChanged(StatusFilter.all),
          ),
          const SizedBox(width: 8),
          _Tab(
            label: S.of(context).toDo,
            selected: value == StatusFilter.todo,
            selectedColor: AppColors.primary,
            unselectedBg: AppColors.statusTodoBg,
            onTap: () => onChanged(StatusFilter.todo),
          ),
          const SizedBox(width: 8),
          _Tab(
            label: S.of(context).inProgress,
            selected: value == StatusFilter.inProgress,
            selectedColor: AppColors.primary,
            unselectedBg: AppColors.statusInProgressBg,
            onTap: () => onChanged(StatusFilter.inProgress),
          ),
          const SizedBox(width: 8),
          _Tab(
            label: S.of(context).completed,
            selected: value == StatusFilter.completed,
            selectedColor: AppColors.primary,
            unselectedBg: AppColors.statusDoneBg,
            onTap: () => onChanged(StatusFilter.completed),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.unselectedBg,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color selectedColor;
  final Color unselectedBg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? selectedColor : unselectedBg;
    final fg = selected ? Colors.white : Colors.black87;
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
