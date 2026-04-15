import 'package:flutter/material.dart';

import '../../core/utils/app_date_utils.dart';

class MonthLabel extends StatelessWidget {
  const MonthLabel({
    super.key,
    required this.month,
    required this.onTapPrevious,
    required this.onTapNext,
    required this.onTapLabel,
  });

  final DateTime month;
  final VoidCallback onTapPrevious;
  final VoidCallback onTapNext;
  final VoidCallback onTapLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconButton(
          onPressed: onTapPrevious,
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Tháng trước',
        ),
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTapLabel,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatMonthLabel(month),
                    style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: onTapNext,
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Tháng sau',
        ),
      ],
    );
  }
}
