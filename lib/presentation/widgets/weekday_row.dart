import 'package:flutter/material.dart';

import '../../core/utils/app_date_utils.dart';
import '../../domain/models/start_of_week.dart';

class WeekdayRow extends StatelessWidget {
  const WeekdayRow({super.key, required this.startOfWeek});

  final StartOfWeek startOfWeek;

  @override
  Widget build(BuildContext context) {
    final labels = weekdayLabels(startOfWeek);
    return Row(
      children: [
        for (final label in labels)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
