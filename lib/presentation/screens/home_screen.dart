import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/app_providers.dart';
import '../../core/utils/app_date_utils.dart';
import '../../domain/models/start_of_week.dart';
import '../widgets/calendar_header.dart';
import '../widgets/month_grid.dart';
import '../widgets/month_label.dart';
import '../widgets/weekday_row.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final PageController _pageController;
  static const int _initialPage = 1200;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarControllerProvider);
    final controller = ref.read(calendarControllerProvider.notifier);
    final lunarService = ref.watch(lunarCalendarServiceProvider);
    final selectedLunarDate = lunarService.convertSolarToLunar(state.selectedDate);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: CalendarHeader(
                selectedDate: state.selectedDate,
                lunarDate: selectedLunarDate,
                onTapToday: () {
                  controller.goToToday();
                  _pageController.jumpToPage(_initialPage);
                },
                onTapSettings: () => _showStartOfWeekSheet(context, state.startOfWeek),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x11000000),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MonthLabel(month: state.displayedMonth),
                    const SizedBox(height: 8),
                    WeekdayRow(startOfWeek: state.startOfWeek),
                    const SizedBox(height: 8),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (pageIndex) {
                          /// REVIEW NOTE:
                          /// We map PageView movement to month browsing only.
                          /// selectedDate intentionally remains untouched here.
                          final delta = pageIndex - _initialPage;
                          controller.changeDisplayedMonth(
                            addMonth(DateTime.now(), delta),
                          );
                        },
                        itemBuilder: (context, index) {
                          final delta = index - _initialPage;
                          final pageMonth = addMonth(DateTime.now(), delta);
                          final days = controller.buildMonthGrid(month: pageMonth);
                          return MonthGrid(
                            days: days,
                            onTapDay: (day) => controller.selectDate(day.solarDate),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showStartOfWeekSheet(
    BuildContext context,
    StartOfWeek currentValue,
  ) async {
    final controller = ref.read(calendarControllerProvider.notifier);
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Bắt đầu tuần vào thứ 2'),
                trailing: currentValue == StartOfWeek.monday
                    ? const Icon(Icons.check, color: Color(0xFFB45309))
                    : null,
                onTap: () {
                  controller.updateStartOfWeek(StartOfWeek.monday);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Bắt đầu tuần vào chủ nhật'),
                trailing: currentValue == StartOfWeek.sunday
                    ? const Icon(Icons.check, color: Color(0xFFB45309))
                    : null,
                onTap: () {
                  controller.updateStartOfWeek(StartOfWeek.sunday);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
