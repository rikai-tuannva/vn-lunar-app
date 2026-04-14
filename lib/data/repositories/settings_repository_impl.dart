import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/start_of_week.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const _startOfWeekKey = 'start_of_week';

  @override
  Future<StartOfWeek> getStartOfWeek() async {
    final prefs = await SharedPreferences.getInstance();
    final rawValue = prefs.getString(_startOfWeekKey);
    return rawValue == StartOfWeek.sunday.name ? StartOfWeek.sunday : StartOfWeek.monday;
  }

  @override
  Future<void> saveStartOfWeek(StartOfWeek value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_startOfWeekKey, value.name);
  }
}
