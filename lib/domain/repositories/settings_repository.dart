import '../models/start_of_week.dart';

abstract class SettingsRepository {
  Future<StartOfWeek> getStartOfWeek();
  Future<void> saveStartOfWeek(StartOfWeek value);
}
