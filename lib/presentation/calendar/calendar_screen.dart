import 'package:diary_flutter/presentation/calendar/calendar.dart';
import 'package:diary_flutter/presentation/calendar/calendar_change_notifier.dart';
import 'package:diary_flutter/presentation/calendar/calendar_inherited_notifier.dart';
import 'package:diary_flutter/presentation/calendar/calendar_journal_card.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarScreen extends ConsumerWidget {
  static const String path = '/calendar';
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverList.separated(
              itemCount: 100000 + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CalendarInheritedNotifier(
                    notifier: CalendarChangeNotifier(
                      dateTime: DateTime.now(),
                    ),
                    child: const Calendar(),
                  );
                } else {
                  return const CalendarJournalCard();
                }
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
            ),
          ],
        ),
      ),
    );
  }
}
