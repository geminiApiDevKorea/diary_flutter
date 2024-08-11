import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:diary_flutter/presentation/calendar/calendar_inherited_notifier.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarHeader extends ConsumerWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = GemTheme.of(ref).textStyle;
    final calendarChangeNotifier = CalendarInheritedNotifier.watch(context);
    final selectedDateTime = calendarChangeNotifier.selectedDateTime;
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => calendarChangeNotifier.previousMonth(),
              child: GenAssets.images.leftArrow.image(scale: 2),
            ),
            const SizedBox(width: 40),
            Text(
              '${selectedDateTime.year}.${selectedDateTime.month.toString().padLeft(2, '0')}',
              style: textStyle.paragraph.withColor(
                const Color(0xFF1D1D1D),
              ),
            ),
            const SizedBox(width: 40),
            InkWell(
              onTap: () => calendarChangeNotifier.nextMonth(),
              child: Transform.flip(
                flipX: true,
                child: GenAssets.images.leftArrow.image(scale: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
