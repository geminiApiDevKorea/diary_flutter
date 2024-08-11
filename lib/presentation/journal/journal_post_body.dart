import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/journal/journal_feedback_widget.dart';
import 'package:diary_flutter/presentation/journal/journal_text_field.dart';
import 'package:diary_flutter/presentation/journal/journal_screen.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

class PostJournalBody extends JournalBody {
  const PostJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController(initialScrollOffset: 0);
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final chatFeedback = ref.watch(chatsFeedbackNotifierProvider);
    // final nowDate = DateTime.now();
    final focusedDate = ref.watch(focusedDateProvider);
    final getMyJournal = ref.watch(getMyJournalByDateProvider(focusedDate));
    // useScrollAnimateToBottom(
    //   scrollController: scrollController,
    //   scrollTriggerValue: getMyJournal,
    // );
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
        });
      });
      return null;
    }, [getMyJournal]);

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
              feedbackType: FeedbackType.post,
            ),
            JournalTextField(
                feedbackType: FeedbackType.post, date: focusedDate),
            chatFeedback.when(
              data: (state) => ChatFeedbackWidget(
                state: state,
                myJournal: getMyJournal,
              ),
              loading: () => const ChatFeedbackLoadingWidget(),
              error: (error, stack) => Text('Error: $error',
                  style: textStyle.h4.copyWith(color: colors.error)),
            ),
          ],
        ),
      ),
    );
  }
}
