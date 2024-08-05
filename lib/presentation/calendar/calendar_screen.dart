import 'package:diary_flutter/presentation/calendar/calendar_change_notifier.dart';
import 'package:diary_flutter/presentation/calendar/calendar_inherited_notifier.dart';
import 'package:diary_flutter/presentation/calendar/monthly_calendart_diary.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarScreen extends ConsumerWidget {
  static const String path = '/$name';
  static const String name = 'calendar';
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        bottom: false,
        child: CalendarInheritedNotifier(
          notifier: CalendarChangeNotifier(
            selectedDateTime: DateTime.now(),
          ),
          child: const MonthlyCalendartDiary(),
        ),
      ),
    );
  }
}
