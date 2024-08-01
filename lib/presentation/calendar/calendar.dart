import 'package:diary_flutter/presentation/calendar/calendar_days.dart';
import 'package:diary_flutter/presentation/calendar/calendar_inherited_notifier.dart';
import 'package:diary_flutter/presentation/calendar/calendar_header.dart';
import 'package:diary_flutter/presentation/calendar/calendar_weekend.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Calendar extends ConsumerWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarChangeNotifier = CalendarInheritedNotifier.watch(context);
    final weekdaysInMonth = calendarChangeNotifier.weekdaysInMonth();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 13.0,
      ),
      child: Column(
        children: [
          CalendarHeader(
            dateTime: calendarChangeNotifier.dateTime,
          ),
          const SizedBox(height: 24),
          const CalendarWeekend(),
          CalendarDays(weekdaysInMonth: weekdaysInMonth),
        ],
      ),
    );
  }
}
