import '../../domain/models/lunar_date.dart';
import '../../domain/services/lunar_calendar_service.dart';

class VietnameseLunarCalendarService implements LunarCalendarService {
  @override
  LunarDate convertSolarToLunar(DateTime solarDate) {
    /// REVIEW NOTE:
    /// This is a temporary placeholder conversion so the UI/state flow can be
    /// built and reviewed first. Replace this implementation with a verified
    /// Vietnamese lunar conversion algorithm or a well-tested package before
    /// releasing the app.
    ///
    /// Important because this function is core business logic and directly
    /// affects user trust in the app.
    return LunarDate(
      day: solarDate.day,
      month: solarDate.month,
      year: solarDate.year,
    );
  }
}
