import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/presentation/calendar/weekday_row_builder.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarWeekend extends ConsumerWidget {
  const CalendarWeekend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textStyle = GemTheme.of(ref).textStyle;
    return WeekdayRowBuilder(
      itemBuilder: (context, weekday) {
        return SizedBox(
          width: 40,
          child: Center(
            child: Transform.translate(
              offset: const Offset(0, -6),
              child: Text(
                weekday.name,
                style: textStyle.button.withColor(
                  const Color(0xFF0C0C0C).withOpacity(0.56),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
