import 'package:flutter/material.dart';

import '../../domain/models/calendar_day.dart';
import 'day_cell.dart';

class MonthGrid extends StatelessWidget {
  const MonthGrid({super.key, required this.days, required this.onTapDay});

  final List<CalendarDay> days;
  final ValueChanged<CalendarDay> onTapDay;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final day = days[index];
        return DayCell(day: day, onTap: () => onTapDay(day));
      },
    );
  }
}
