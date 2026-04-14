import 'package:flutter/material.dart';

import '../../domain/models/calendar_day.dart';

class DayCell extends StatelessWidget {
  const DayCell({super.key, required this.day, required this.onTap});

  final CalendarDay day;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final baseTextColor = day.isInDisplayedMonth ? Colors.black87 : Colors.black45;
    final backgroundColor = day.isSelected
        ? const Color(0xFFB45309)
        : day.isToday
            ? const Color(0xFFFDEBD2)
            : Colors.transparent;
    final textColor = day.isSelected ? Colors.white : baseTextColor;

    return Opacity(
      opacity: day.isInDisplayedMonth ? 1 : 0.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: day.isToday && !day.isSelected
                ? Border.all(color: const Color(0xFFB45309), width: 1.2)
                : null,
          ),
          child: Center(
            child: Text(
              '${day.solarDate.day}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
