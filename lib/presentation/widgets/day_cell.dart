import 'package:flutter/material.dart';

import '../../core/utils/app_date_utils.dart';
import '../../domain/models/calendar_day.dart';

class DayCell extends StatelessWidget {
  const DayCell({super.key, required this.day, required this.onTap});

  final CalendarDay day;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final baseTextColor =
        day.isInDisplayedMonth ? const Color(0xFF1F2937) : Colors.black45;
    final secondaryTextColor = day.isSelected
        ? Colors.white70
        : day.isInDisplayedMonth
            ? const Color(0xFF92400E)
            : Colors.black38;
    final backgroundColor = day.isSelected
        ? const Color(0xFFB45309)
        : day.isToday
            ? const Color(0xFFFFF2E2)
            : Colors.transparent;
    final textColor = day.isSelected ? Colors.white : baseTextColor;

    return Opacity(
      opacity: day.isInDisplayedMonth ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(4),
            child: Ink(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(18),
                border: day.isToday && !day.isSelected
                    ? Border.all(color: const Color(0xFFB45309), width: 1.2)
                    : null,
                boxShadow: day.isSelected
                    ? const [
                        BoxShadow(
                          color: Color(0x2AB45309),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${day.solarDate.day}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      formatShortLunarDay(day.lunarDate.day),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: secondaryTextColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
