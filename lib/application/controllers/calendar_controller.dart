import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/app_date_utils.dart';
import '../../domain/models/calendar_day.dart';
import '../../domain/models/start_of_week.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/services/lunar_calendar_service.dart';
import '../providers/app_providers.dart';
import '../state/calendar_state.dart';

class CalendarController extends Notifier<CalendarState> {
  CalendarController();

  late final LunarCalendarService _lunarCalendarService;
  late final SettingsRepository _settingsRepository;

  @override
  CalendarState build() {
    _lunarCalendarService = ref.read(lunarCalendarServiceProvider);
    _settingsRepository = ref.read(settingsRepositoryProvider);
    Future.microtask(loadSettings);
    return CalendarState.initial();
  }

  Future<void> loadSettings() async {
    state = state.copyWith(isLoading: true);
    final startOfWeek = await _settingsRepository.getStartOfWeek();
    state = state.copyWith(startOfWeek: startOfWeek, isLoading: false);
  }

  /// Updates selected date when the user taps a calendar cell.
  ///
  /// REVIEW NOTE:
  /// If the user taps a day rendered from the previous/next month, we also move
  /// displayedMonth to that day's month. This keeps header and month grid in
  /// sync with the user's explicit selection.
  void selectDate(DateTime date) {
    final normalized = normalizeDate(date);
    state = state.copyWith(
      selectedDate: normalized,
      displayedMonth: DateTime(normalized.year, normalized.month, 1),
    );
  }

  /// Resets both selectedDate and displayedMonth to today.
  ///
  /// REVIEW NOTE:
  /// Both fields must be updated together so the header and the visible month
  /// always jump back to the same point in time.
  void goToToday() {
    final today = normalizeDate(DateTime.now());
    state = state.copyWith(
      selectedDate: today,
      displayedMonth: firstDayOfMonth(today),
    );
  }

  /// Changes only the visible month when the user swipes horizontally.
  ///
  /// REVIEW NOTE:
  /// This intentionally does NOT update selectedDate. Swiping is treated as
  /// browsing months, while tapping is treated as choosing a date.
  void changeDisplayedMonth(DateTime month) {
    state = state.copyWith(displayedMonth: firstDayOfMonth(month));
  }

  Future<void> updateStartOfWeek(StartOfWeek value) async {
    await _settingsRepository.saveStartOfWeek(value);
    state = state.copyWith(startOfWeek: value);
  }

  List<CalendarDay> buildMonthGrid({DateTime? month}) {
    final targetMonth = firstDayOfMonth(month ?? state.displayedMonth);
    final gridStart = calculateGridStart(targetMonth, state.startOfWeek);

    /// REVIEW NOTE:
    /// Always generating 42 cells keeps the calendar height stable and makes
    /// month rendering predictable during review across all edge cases.
    return List.generate(42, (index) {
      final solarDate = gridStart.add(Duration(days: index));
      return CalendarDay(
        solarDate: solarDate,
        lunarDate: _lunarCalendarService.convertSolarToLunar(solarDate),
        isInDisplayedMonth: solarDate.year == targetMonth.year && solarDate.month == targetMonth.month,
        isSelected: isSameDate(solarDate, state.selectedDate),
        isToday: isSameDate(solarDate, normalizeDate(DateTime.now())),
      );
    });
  }

  /// Calculates the first visible date in the 6x7 month grid.
  ///
  /// REVIEW NOTE:
  /// Dart uses Monday=1 ... Sunday=7. The offset formula changes depending on
  /// the configured week start and is easy to get wrong during refactors.
  DateTime calculateGridStart(DateTime firstDayOfMonthValue, StartOfWeek startOfWeek) {
    final weekday = firstDayOfMonthValue.weekday;
    final offset = switch (startOfWeek) {
      StartOfWeek.monday => weekday - DateTime.monday,
      StartOfWeek.sunday => weekday % 7,
    };
    return firstDayOfMonthValue.subtract(Duration(days: offset));
  }
}
