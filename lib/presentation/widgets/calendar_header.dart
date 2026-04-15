import 'package:flutter/material.dart';

import '../../core/utils/app_date_utils.dart';
import '../../domain/models/lunar_date.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    required this.selectedDate,
    required this.lunarDate,
    required this.onTapToday,
    required this.onTapSettings,
  });

  final DateTime selectedDate;
  final LunarDate lunarDate;
  final VoidCallback onTapToday;
  final VoidCallback onTapSettings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFBF5), Color(0xFFFAF7F2)],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFDEBD2),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Hôm nay',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF92400E),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: onTapToday, child: const Text('ToDay')),
                IconButton(
                  onPressed: onTapSettings,
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lunarDate.displayText,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF7C2D12),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  formatSolarDateVi(selectedDate),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
