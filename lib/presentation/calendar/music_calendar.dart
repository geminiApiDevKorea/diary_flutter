import 'package:diary_flutter/presentation/calendar/calendar_days.dart';
import 'package:diary_flutter/presentation/calendar/calendar_header.dart';
import 'package:diary_flutter/presentation/calendar/calendar_weekend.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MusicCalendar extends ConsumerWidget {
  const MusicCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        children: [
          CalendarHeader(),
          SizedBox(height: 24),
          CalendarWeekend(),
          CalendarMusicDays(),
        ],
      ),
    );
  }
}
