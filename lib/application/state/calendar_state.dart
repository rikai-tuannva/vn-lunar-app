import '../../domain/models/start_of_week.dart';

class CalendarState {
  const CalendarState({
    required this.selectedDate,
    required this.displayedMonth,
    required this.startOfWeek,
    this.isLoading = false,
  });

  final DateTime selectedDate;
  final DateTime displayedMonth;
  final StartOfWeek startOfWeek;
  final bool isLoading;

  CalendarState copyWith({
    DateTime? selectedDate,
    DateTime? displayedMonth,
    StartOfWeek? startOfWeek,
    bool? isLoading,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      displayedMonth: displayedMonth ?? this.displayedMonth,
      startOfWeek: startOfWeek ?? this.startOfWeek,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory CalendarState.initial() {
    final today = DateTime.now();
    return CalendarState(
      selectedDate: DateTime(today.year, today.month, today.day),
      displayedMonth: DateTime(today.year, today.month, 1),
      startOfWeek: StartOfWeek.monday,
    );
  }
}
