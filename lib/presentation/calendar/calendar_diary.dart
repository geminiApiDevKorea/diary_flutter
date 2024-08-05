import 'package:diary_flutter/domain/provider/diary/diary_use_cases.dart';
import 'package:diary_flutter/presentation/calendar/calendar_scroll_view.dart';
import 'package:diary_flutter/presentation/calendar/calendar_inherited_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:core';

class CalendarDiary extends ConsumerWidget {
  const CalendarDiary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarChangeNotifier = CalendarInheritedNotifier.watch(context);
    return ref
        .watch(
          getDiariesProvider(calendarChangeNotifier.selectedDateTime),
        )
        .when(
          data: (diaryResponse) => CalendarScrollView(
            musicDiaries: diaryResponse.diary,
          ),
          loading: () => CalendarScrollView(
            musicDiaries: List.empty(),
          ),
          error: (error, stackTrace) => Text('Error: $error'),
        );
  }
}
