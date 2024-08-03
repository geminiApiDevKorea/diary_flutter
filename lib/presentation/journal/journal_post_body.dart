import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/journal/journal_service.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/journal/journal_music_card.dart';
import 'package:diary_flutter/presentation/journal/journal_text_field.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostJournalBody extends HookConsumerWidget {
  const PostJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final chatFeedback = ref.watch(chatsFeedbackNotifierProvider);
    final nowDate = DateTime.now();
    final getMyJournal = ref.watch(getMyJournalByDateProvider(nowDate));
    Print.red(getMyJournal.toString());
    ref.listen<AsyncValue<ChatsFeedbackState>>(
      chatsFeedbackNotifierProvider,
      (previous, next) {
        next.whenData((data) async {
          if (data is ChatsFeedbackData) {
            final journal =
                await ref.read(myJournalStoreProvider.notifier).read(nowDate);
            if (journal != null) {
              final updatedJournal = journal.copyWith(
                  music: data.data.music,
                  song: data.data.feedbackResponse.song);
              await ref
                  .read(myJournalStoreProvider.notifier)
                  .createOrUpdate(updatedJournal);
            }
          }
        });
      },
    );

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        color: colors.grayScale90,
        padding: const EdgeInsets.fromLTRB(16, 57, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateHeaderDisplay(date: nowDate),
            JournalTextField(date: nowDate),
            chatFeedback.when(
              data: (state) {
                if (state is ChatsFeedbackData) {
                  return JournalMusicCard(
                    bottomText: state.data.music.title ?? '',
                    imgUrl: state.data.music.thumbnailUrl ?? '',
                    onButtonPressed: () {
                      print(state.data.music.url ?? '');
                    },
                  );
                } else if (state is ChatsFeedbackError) {
                  if (state.statusCode == 401) {
                    return const Text("다시로그인해주세요");
                  }
                  if (state.statusCode == 400) {
                    return const Text("일기내용이없습니다");
                  }
                  return Text('Error: ${state.error}',
                      style: textStyle.h4.copyWith(color: colors.error));
                } else {
                  if (getMyJournal?.music == null) {
                    return const SizedBox();
                  } else {
                    return JournalMusicCard(
                        bottomText: getMyJournal?.music?.title ?? '',
                        imgUrl: getMyJournal?.music?.thumbnailUrl ?? '',
                        onButtonPressed: () {
                          print(getMyJournal?.music?.url ?? '');
                        });
                  }
                }
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error',
                  style: textStyle.h4.copyWith(color: colors.error)),
            ),
          ],
        ),
      ),
    );
  }
}
