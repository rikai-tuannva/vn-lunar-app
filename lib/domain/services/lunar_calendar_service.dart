import '../models/lunar_date.dart';

abstract class LunarCalendarService {
  LunarDate convertSolarToLunar(DateTime solarDate);
}
