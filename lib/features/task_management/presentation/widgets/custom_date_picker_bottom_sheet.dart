import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_manager/theme/app_colors.dart';
// Localization removed to keep widget self-contained


class CustomDatePickerBottomSheet extends StatefulWidget {
  const CustomDatePickerBottomSheet({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.title,
    this.subtitle,
    this.buttonColor,
    this.selectedDateColor,
  });

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final String? title;
  final String? subtitle;
  final Color? buttonColor;
  final Color? selectedDateColor;

  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? title,
    String? subtitle,
    Color? buttonColor,
    Color? selectedDateColor,
  }) {
    return showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomDatePickerBottomSheet(
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2020),
        lastDate: lastDate ?? DateTime(2030),
        title: title,
        subtitle: subtitle,
        buttonColor: buttonColor,
        selectedDateColor: selectedDateColor,
        onDateSelected: (date) => Navigator.of(context).pop(date),
      ),
    );
  }

  @override
  State<CustomDatePickerBottomSheet> createState() => _CustomDatePickerBottomSheetState();
}

class _CustomDatePickerBottomSheetState extends State<CustomDatePickerBottomSheet> {
  static const List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  late DateTime _selectedDate;
  late DateTime _currentMonth;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
    _selectedTime = TimeOfDay(hour: _selectedDate.hour, minute: _selectedDate.minute);
  }

  List<DateTime> _generateCalendarDays() {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    // Monday-based week: weekday 1 (Mon) .. 7 (Sun)
    final daysFromMonday = (firstDayOfMonth.weekday - DateTime.monday) % 7;
    final firstCalendarDay = firstDayOfMonth.subtract(Duration(days: daysFromMonday));

    final days = <DateTime>[];
    var current = firstCalendarDay;
    // Fill 6 weeks grid (6 * 7 = 42)
    while (days.length < 42) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }

    // Make sure grid includes end of month; extend if needed (usually not needed)
    if (days.last.isBefore(lastDayOfMonth)) {
      while (days.last.isBefore(lastDayOfMonth)) {
        days.add(days.last.add(const Duration(days: 1)));
      }
    }
    return days;
  }

  bool _isCurrentMonth(DateTime date) => date.month == _currentMonth.month && date.year == _currentMonth.year;
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool _isSelected(DateTime date) =>
      date.year == _selectedDate.year && date.month == _selectedDate.month && date.day == _selectedDate.day;

  bool _isDisabled(DateTime date) {
    final first = widget.firstDate ?? DateTime(2020);
    final last = widget.lastDate ?? DateTime(2030);
    return date.isBefore(DateTime(first.year, first.month, first.day)) ||
        date.isAfter(DateTime(last.year, last.month, last.day, 23, 59, 59));
  }

  void _previousMonth() {
    setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1));
  }

  void _nextMonth() {
    setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1));
  }

  @override
  Widget build(BuildContext context) {
    final calendarDays = _generateCalendarDays();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 10,
            color: Color(0x19191919),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0x59AAB2BC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                if (widget.title != null || widget.subtitle != null) ...[
                  Text(
                    widget.title ?? 'Select a date',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkText),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitle ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: AppColors.darkText),
                  ),
                  const SizedBox(height: 16),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _previousMonth,
                      icon: const Icon(Icons.chevron_left, color: Color(0xFFA4A7AE)),
                    ),
                    Text(
                      '${_months[_currentMonth.month - 1]} ${_currentMonth.year}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF414651)),
                    ),
                    IconButton(
                      onPressed: _nextMonth,
                      icon: const Icon(Icons.chevron_right, color: Color(0xFFA4A7AE)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.15,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(
                        _weekDays[index],
                        style: const TextStyle(fontSize: 12, color: Color(0xFF414651)),
                      ),
                    );
                  },
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.15,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: calendarDays.length,
                  itemBuilder: (context, index) {
                    final date = calendarDays[index];
                    final isCurrentMonth = _isCurrentMonth(date);
                    final isToday = _isToday(date);
                    final isSelected = _isSelected(date);
                    final isDisabled = _isDisabled(date);
        
                    final textColor = isSelected
                        ? Colors.white
                        : !isCurrentMonth
                            ? const Color(0xFF717680)
                            : isDisabled
                                ? const Color(0xFF414651).withOpacity(0.2)
                                : const Color(0xFF414651);
        
                    return GestureDetector(
                      onTap: isDisabled
                          ? null
                          : () => setState(() {
                                _selectedDate = date;
                              }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (widget.selectedDateColor ?? AppColors.primary)
                              : isToday && isCurrentMonth
                                  ? const Color(0xFFF9FAFB)
                                  : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text('${date.day}', style: TextStyle(fontSize: 14, color: textColor)),
                            if (isToday && !isSelected)
                              const Positioned(
                                bottom: 4,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: Color(0xFF6366F1), shape: BoxShape.circle),
                                  child: SizedBox(width: 5, height: 5),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      _formatTime(_selectedTime),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: _showCupertinoTimePicker,
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Pick time'),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      final result = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                        _selectedTime.hour,
                        _selectedTime.minute,
                      );
                      widget.onDateSelected?.call(result);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.buttonColor ?? AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Save',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _showCupertinoTimePicker() async {
    final initial = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => _CupertinoTimePickerSheet(
        initialDateTime: initial,
        onChanged: (dt) {
          setState(() => _selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute));
        },
      ),
    );
  }
}

class _CupertinoTimePickerSheet extends StatelessWidget {
  const _CupertinoTimePickerSheet({
    required this.initialDateTime,
    required this.onChanged,
  });

  final DateTime initialDateTime;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: initialDateTime,
              use24hFormat: false,
              onDateTimeChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
