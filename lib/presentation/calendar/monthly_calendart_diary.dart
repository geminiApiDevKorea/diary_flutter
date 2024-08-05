import 'package:diary_flutter/domain/provider/diary/diary_use_cases.dart';
import 'package:diary_flutter/presentation/calendar/calendar.dart';
import 'package:diary_flutter/presentation/calendar/calendar_inherited_notifier.dart';
import 'package:diary_flutter/presentation/calendar/calendar_journal_card.dart';
import 'package:diary_flutter/presentation/calendar/calendar_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthlyCalendartDiary extends ConsumerWidget {
  const MonthlyCalendartDiary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarChangeNotifier = CalendarInheritedNotifier.watch(context);
    return ref
        .watch(getDiariesProvider(calendarChangeNotifier.selectedDateTime))
        .when(
      data: (diaries) {
        return CustomScrollView(
          slivers: [
            SliverList.separated(
              itemCount: diaries.length + 2,
              itemBuilder: (context, index) => switch (index) {
                0 => const CalendarScreenHeader(),
                1 => const Calendar(),
                _ => CalendarJournalCard(
                    diary: diaries.elementAt(index + 2),
                  ),
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
            ),
          ],
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        return Text('Error: $error');
      },
    );
  }
}
