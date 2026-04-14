import 'package:flutter/material.dart';

import '../../core/utils/app_date_utils.dart';

class MonthLabel extends StatelessWidget {
  const MonthLabel({super.key, required this.month});

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatMonthLabel(month),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
