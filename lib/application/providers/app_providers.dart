import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/settings_repository_impl.dart';
import '../../data/services/vietnamese_lunar_calendar_service.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/services/lunar_calendar_service.dart';
import '../controllers/calendar_controller.dart';
import '../state/calendar_state.dart';

final lunarCalendarServiceProvider = Provider<LunarCalendarService>((ref) {
  return VietnameseLunarCalendarService();
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl();
});

final calendarControllerProvider = NotifierProvider<CalendarController, CalendarState>(
  CalendarController.new,
);
