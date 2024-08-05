import 'package:diary_flutter/domain/provider/diary/diary_use_cases.dart';
import 'package:diary_flutter/presentation/calendar/calendar_music_day.dart';
import 'package:diary_flutter/presentation/calendar/calendar_day.dart';
import 'package:diary_flutter/presentation/calendar/calendar_inherited_notifier.dart';
import 'package:diary_flutter/presentation/calendar/weekday_row_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarMusicDays extends ConsumerWidget {
  const CalendarMusicDays({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarChangeNotifier = CalendarInheritedNotifier.watch(context);
    final weekdaysInMonth = calendarChangeNotifier.weekdaysInMonth;
    final selectedDateTime = calendarChangeNotifier.selectedDateTime;

    return SizedBox(
      width: double.infinity,
      height: 52.0 * weekdaysInMonth,
      child: Column(
        children: [
          for (var i = 0; i < weekdaysInMonth; i++)
            WeekdayRowBuilder(
              itemBuilder: (context, weekday) {
                final day = calendarChangeNotifier.dayInMonth(i, weekday);
                if (day == null) {
                  return const SizedBox(width: 40);
                } else {
                  return ref
                      .watch(
                        getDiaryProvider(selectedDateTime.copyWith(day: day)),
                      )
                      .when(
                        data: (diary) => diary == null
                            ? CalendarDay(day: day)
                            : CalendarMusicDay(musicDiary: diary),
                        error: (error, stackTrace) => const SizedBox(width: 40),
                        loading: () => CalendarDay(day: day),
                      );
                }
              },
            ),
        ],
      ),
    );
  }
}
