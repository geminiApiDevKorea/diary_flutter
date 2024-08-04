import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/journal/journal_music_card.dart';
import 'package:diary_flutter/presentation/journal/journal_text_field.dart';
import 'package:diary_flutter/presentation/journal/listener/listener.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

class PostJournalBody extends HookConsumerWidget with PostJournalHandlerMixin {
  const PostJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final chatFeedback = ref.watch(chatsFeedbackNotifierProvider);
    // final nowDate = DateTime.now();
    final focusedDate = ref.watch(focusedDateProvider);
    final getMyJournal = ref.watch(getMyJournalByDateProvider(focusedDate));

    useListeners(
      context,
      ref,
      [
        ChatFeedbackListener(focusedDate),
      ],
      [focusedDate],
    );

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        color: colors.grayScale90,
        padding: const EdgeInsets.fromLTRB(16, kTextTabBarHeight, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateHeaderDisplay(date: focusedDate),
            JournalTextField(date: focusedDate),
            chatFeedback.when(
              data: (state) =>
                  buildChatFeedbackWidget(state, ref, getMyJournal),
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
      ChatsFeedbackState state, WidgetRef ref, Journal? myJournal) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;

    if (state is ChatsFeedbackData) {
      return JournalMusicCard(
        bottomText: state.data.music.title,
        imgUrl: state.data.music.thumbnailUrl,
        onButtonPressed: () {
          //TODO: 음악재생 로직 추가!!
          // print(state.data.music.url);
        },
      );
    } else if (state is ChatsFeedbackError) {
      if (state.statusCode == 401) {
        //TODO: 재로그인 로직 추가!!
        Print.red("다시 로그인해주세요");
        return const JournalMusicCard(
          imgUrl: null,
          bottomText: null,
          onButtonPressed: null,
        );
      }
      if (state.statusCode == 400) {
        return const Text("일기 내용이 없습니다");
      }
      if (state.statusCode == 500) {
        Print.red(state.error);
        return const Text("에러가 발생했습니다");
      }
      return Text('Error: ${state.error}',
          style: textStyle.h4.copyWith(color: colors.error));
    } else {
      if (myJournal?.music == null) {
        return const SizedBox();
      } else {
        return JournalMusicCard(
            bottomText: myJournal?.music?.title ?? '',
            imgUrl: myJournal?.music?.thumbnailUrl ?? '',
            onButtonPressed: () {
              // print(myJournal?.music?.url ?? '');
            });
      }
    }
  }

  Widget buildChatFeedbackLoadingWidget() {
    return const JournalMusicCard(
      imgUrl: null,
      bottomText: null,
      onButtonPressed: null,
    );
  }
}
