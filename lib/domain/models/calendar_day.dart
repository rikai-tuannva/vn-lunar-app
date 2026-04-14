import 'lunar_date.dart';

class CalendarDay {
  const CalendarDay({
    required this.solarDate,
    required this.lunarDate,
    required this.isInDisplayedMonth,
    required this.isSelected,
    required this.isToday,
  });

  final DateTime solarDate;
  final LunarDate lunarDate;
  final bool isInDisplayedMonth;
  final bool isSelected;
  final bool isToday;
}
