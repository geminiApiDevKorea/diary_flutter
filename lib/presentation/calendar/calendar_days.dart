import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/repository/diary_repository.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/diary/diary_use_cases.dart';
import 'package:diary_flutter/presentation/calendar/calendar_music_day.dart';
import 'package:diary_flutter/presentation/calendar/calendar_day.dart';
import 'package:diary_flutter/presentation/calendar/calendar_inherited_notifier.dart';
import 'package:diary_flutter/presentation/calendar/weekday_row_builder.dart';
import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/journal/journal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CalendarMusicDays extends ConsumerWidget {
  const CalendarMusicDays({super.key});

  _onTap(BuildContext context, WidgetRef ref, MusicDiary diary) async {
    await ref
        .read(focusedDateProvider.notifier)
        .updateDate(diary.dateTime)
        .then(
      (_) {
        context.pushNamed(
          JournalScreen.name,
          queryParameters: {
            QueryParameterKeys.feedbackType.value: diary.type.value,
          },
        );
      },
    );
  }

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
                            : CalendarMusicDay(
                                musicDiary: diary,
                                onTap: () => _onTap(context, ref, diary),
                              ),
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
