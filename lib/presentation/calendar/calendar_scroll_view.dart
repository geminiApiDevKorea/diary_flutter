import 'package:diary_flutter/data/repository/diary_repository.dart';
import 'package:diary_flutter/presentation/calendar/calendar_diary_navigation_bar.dart';
import 'package:diary_flutter/presentation/calendar/calendar_journal_card.dart';
import 'package:diary_flutter/presentation/calendar/music_calendar.dart';
import 'package:flutter/cupertino.dart';

class CalendarScrollView extends StatelessWidget {
  final List<MusicDiary> musicDiaries;
  const CalendarScrollView({
    super.key,
    required this.musicDiaries,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.separated(
          itemCount: musicDiaries.length + 2,
          itemBuilder: (context, index) => switch (index) {
            0 => const CalendarDiaryNavigationBar(),
            1 => const MusicCalendar(),
            _ => CalendarJournalCard(
                diary: musicDiaries.elementAt(index - 2),
              ),
          },
          separatorBuilder: (context, index) => const SizedBox(height: 20),
        ),
      ],
    );
  }
}
