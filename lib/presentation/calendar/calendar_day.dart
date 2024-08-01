import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarDay extends ConsumerWidget {
  final int day;
  const CalendarDay({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = GemTheme.of(ref).textStyle;
    return Center(
      child: Text(
        '$day',
        style: textStyle.button.withColor(
          const Color(0xFF0C0C0C).withOpacity(0.56),
        ),
      ),
    );
  }
}
