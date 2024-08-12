import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/extension/date_time_extension.dart';
import 'package:diary_flutter/data/repository/diary_repository.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/gen/gen_assets.dart';
import 'package:diary_flutter/presentation/calendar/calendar_journal_music_chip.dart';
import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/journal/journal_screen.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CalendarJournalCard extends ConsumerWidget {
  final MusicDiary diary;
  const CalendarJournalCard({
    super.key,
    required this.diary,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = GemTheme.of(ref).textStyle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () async {
            await ref
                .read(focusedDateProvider.notifier)
                .updateDate(diary.dateTime)
                .then(
              (_) {
                context.pushNamed(
                  JournalScreen.name,
                  queryParameters: {
                    QueryParameterKeys.feedbackType.value: diary.type.value,
                  },
                );
              },
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GenAssets.images.lock.image(scale: 2),
                    const SizedBox(width: 10),
                    Text(
                      '${diary.dateTime.monthDayOrdinal}, ${diary.dateTime.year} · ${diary.type == FeedbackType.post ? 'Posted' : 'Chat'}',
                      style:
                          textStyle.button.withColor(const Color(0xFF484848)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  diary.title,
                  style: textStyle.h1.withFontSize(28).withHeight(1.4),
                ),
                const SizedBox(height: 24),
                CalendarJournalMusicChip(music: diary.music),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
