import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/journal/journal_music_card.dart';
import 'package:diary_flutter/presentation/journal/journal_text_field.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:diary_flutter/presentation/utils/hooks/use_scroll_animate_to_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

class PostJournalBody extends HookConsumerWidget with PostJournalHandlerMixin {
  const PostJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController(initialScrollOffset: 100);
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final chatFeedback = ref.watch(chatsFeedbackNotifierProvider);
    // final nowDate = DateTime.now();
    final focusedDate = ref.watch(focusedDateProvider);
    final getMyJournal = ref.watch(getMyJournalByDateProvider(focusedDate));
    useScrollAnimateToBottom(
      scrollController: scrollController,
      scrollTriggerValue: getMyJournal,
    );

    ref.listen<AsyncValue<ChatsFeedbackState>>(
      chatsFeedbackNotifierProvider,
      (previous, next) {
        next.whenData((data) async {
          if (data is ChatsFeedbackData) {
            final journal = await ref
                .read(myJournalStoreProvider.notifier)
                .read(focusedDate);
            if (journal != null) {
              final updatedJournal = journal.copyWith(
                music: data.data.music,
                song: data.data.feedbackResponse.song,
              );
              Print.green('Updated journal: $updatedJournal');
              await ref
                  .read(myJournalStoreProvider.notifier)
                  .createOrUpdate(updatedJournal);
            }
          }
        });
      },
    );

    return SingleChildScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      child: Container(
        color: colors.grayScale90,
        padding: const EdgeInsets.fromLTRB(16, kTextTabBarHeight, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateHeaderDisplay(
              date: focusedDate,
              journalType: JournalType.post,
            ),
            JournalTextField(journalType: JournalType.post, date: focusedDate),
            chatFeedback.when(
              data: (state) =>
                  buildChatFeedbackWidget(context, state, ref, getMyJournal),
              loading: () => buildChatFeedbackLoadingWidget(),
              error: (error, stack) => Text('Error: $error',
                  style: textStyle.h4.copyWith(color: colors.error)),
            ),
          ],
        ),
      ),
    );
  }
}

mixin PostJournalHandlerMixin {
  Widget buildChatFeedbackWidget(
      BuildContext context, state, WidgetRef ref, Journal? myJournal) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;

    if (state is ChatsFeedbackData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 120,
          ),
          const Divider(),
          const SizedBox(height: 13),
          Text('Muse Recommends you',
              style: textStyle.button.withColor(colors.grayScale70)),
          const SizedBox(height: 10),
          Text(myJournal?.song?.reason ?? '',
              style: textStyle.h5.withHeight(1.3)),
          const SizedBox(height: 36),
          Center(
            child: JournalMusicCard(
                song: myJournal?.song?.title ?? '',
                singer: myJournal?.song?.singer ?? '',
                imgUrl: myJournal?.music?.thumbnailUrl ?? '',
                onButtonPressed: () {
                  // print(myJournal?.music?.url ?? '');
                }),
          ),
        ],
      );
    } else if (state is ChatsFeedbackError) {
      if (state.statusCode == 401) {
        //TODO: 재로그인 로직 추가!!
        Print.red("다시 로그인해주세요");
        return const JournalMusicCard(
          imgUrl: null,
          onButtonPressed: null,
        );
      }
      if (state.statusCode == 400) {
        Print.red("일기 내용이 없습니다");
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Journal is Empty!')),
        //   );
        // });

        return const SizedBox.shrink();
      }
      if (state.statusCode == 500) {
        Print.red(state.error);
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(state.error)),
        //   );
        // });
        return const SizedBox.shrink();
      }
      return Text('Error: ${state.error}',
          style: textStyle.h4.copyWith(color: colors.error));
    } else {
      if (myJournal?.music == null) {
        return const SizedBox();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 120,
            ),
            const Divider(),
            const SizedBox(height: 13),
            Text('Muse Recommends you',
                style: textStyle.button.withColor(colors.grayScale70)),
            const SizedBox(height: 10),
            Text(myJournal?.song?.reason ?? '',
                style: textStyle.h5.withHeight(1.3)),
            const SizedBox(height: 36),
            Center(
              child: JournalMusicCard(
                  // bottomText: myJournal?.music?.title ?? '',
                  song: myJournal?.song?.title,
                  singer: myJournal?.song?.singer,
                  imgUrl: myJournal?.music?.thumbnailUrl ?? '',
                  onButtonPressed: () {
                    // print(myJournal?.music?.url ?? '');
                  }),
            ),
          ],
        );
      }
    }
  }

  Widget buildChatFeedbackLoadingWidget() {
    return const JournalMusicCard(
      imgUrl: null,
      onButtonPressed: null,
    );
  }
}
