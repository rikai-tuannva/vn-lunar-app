import 'package:intl/intl.dart';

import '../../domain/models/start_of_week.dart';

bool isSameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

DateTime normalizeDate(DateTime date) => DateTime(date.year, date.month, date.day);

DateTime firstDayOfMonth(DateTime date) => DateTime(date.year, date.month, 1);

DateTime addMonth(DateTime month, int delta) => DateTime(month.year, month.month + delta, 1);

String formatMonthLabel(DateTime month) => 'Tháng ${month.month.toString().padLeft(2, '0')}/${month.year}';

String formatSolarDateVi(DateTime date) {
  final weekday = switch (date.weekday) {
    DateTime.monday => 'Thứ 2',
    DateTime.tuesday => 'Thứ 3',
    DateTime.wednesday => 'Thứ 4',
    DateTime.thursday => 'Thứ 5',
    DateTime.friday => 'Thứ 6',
    DateTime.saturday => 'Thứ 7',
    DateTime.sunday => 'Chủ nhật',
    _ => '',
  };
  return '$weekday, ${DateFormat('dd/MM/yyyy').format(date)}';
}

List<String> weekdayLabels(StartOfWeek startOfWeek) {
  return startOfWeek == StartOfWeek.monday
      ? const ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN']
      : const ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
}

String formatShortLunarDay(int day) => day.toString().padLeft(2, '0');
