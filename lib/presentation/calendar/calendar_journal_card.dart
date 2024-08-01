import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:diary_flutter/presentation/calendar/calendar_journal_music_chip.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarJournalCard extends ConsumerWidget {
  const CalendarJournalCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = GemTheme.of(ref).textStyle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                GenAssets.images.lock.image(scale: 2),
                const SizedBox(width: 10),
                Text(
                  'July 11st, 2024 · Posted',
                  style: textStyle.button.withColor(const Color(0xFF484848)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Rainy, Drizzle day in my mind. How was your day?',
              style: textStyle.h1.withFontSize(28).withHeight(1.4),
            ),
            const SizedBox(height: 24),
            const CalendarJournalMusicChip(),
          ],
        ),
      ),
    );
  }
}
