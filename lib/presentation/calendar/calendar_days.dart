import 'package:diary_flutter/presentation/calendar/calendar_day.dart';
import 'package:diary_flutter/presentation/calendar/calendar_inherited_notifier.dart';
import 'package:diary_flutter/presentation/calendar/weekday_row_builder.dart';
import 'package:flutter/material.dart';

class CalendarDays extends StatelessWidget {
  final int weekdaysInMonth;
  const CalendarDays({
    super.key,
    required this.weekdaysInMonth,
  });

  @override
  Widget build(BuildContext context) {
    final calendarChangeNotifier = CalendarInheritedNotifier.watch(context);
    return SizedBox(
      width: double.infinity,
      height: 52.0 * weekdaysInMonth,
      child: Column(
        children: [
          for (var i = 0; i < weekdaysInMonth; i++)
            WeekdayRowBuilder(
              itemBuilder: (context, weekday) {
                final day = calendarChangeNotifier.dayInMonth(i, weekday);
                return SizedBox(
                  width: 40,
                  child: day == null ? null : CalendarDay(day: day),
                );
              },
            ),
        ],
      ),
    );
  }
}
