class LunarDate {
  const LunarDate({
    required this.day,
    required this.month,
    required this.year,
    this.isLeapMonth = false,
  });

  final int day;
  final int month;
  final int year;
  final bool isLeapMonth;

  String get displayText {
    final leapSuffix = isLeapMonth ? ' nhuận' : '';
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}$leapSuffix âm lịch';
  }
}
