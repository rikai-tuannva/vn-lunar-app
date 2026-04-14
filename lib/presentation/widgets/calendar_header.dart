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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              TextButton(onPressed: onTapToday, child: const Text('ToDay')),
              IconButton(
                onPressed: onTapSettings,
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          const Spacer(),
          Text(
            lunarDate.displayText,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF7C2D12),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formatSolarDateVi(selectedDate),
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
