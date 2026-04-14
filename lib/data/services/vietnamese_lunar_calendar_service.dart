import 'package:full_calender/full_calender.dart';

import '../../core/utils/app_date_utils.dart';
import '../../domain/models/lunar_date.dart';
import '../../domain/services/lunar_calendar_service.dart';

class VietnameseLunarCalendarService implements LunarCalendarService {
  @override
  LunarDate convertSolarToLunar(DateTime solarDate) {
    /// REVIEW NOTE:
    /// This function contains core business logic. It now delegates lunar
    /// conversion to the `full_calender` package, which is designed around the
    /// Vietnamese lunar calendar rules. Keep this mapping isolated here so the
    /// rest of the app is not coupled to any package-specific model.
    final normalizedDate = normalizeDate(solarDate);
    final lunar = FullCalender(date: normalizedDate, timeZone: 7).lunarDate;

    return LunarDate(
      day: lunar.day,
      month: lunar.month,
      year: lunar.year,
      isLeapMonth: lunar.isLeap,
    );
  }
}
