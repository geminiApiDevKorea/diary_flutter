import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/chats/chats_prompt_notifier.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/journal/assistant_chat_item.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/presentation/journal/journal_post_body.dart';
import 'package:diary_flutter/presentation/journal/journal_text_field.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:diary_flutter/presentation/journal/user_chat_item.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:diary_flutter/presentation/utils/hooks/use_scroll_animate_to_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

class ChatJournalBody extends HookConsumerWidget with PostJournalHandlerMixin {
  const ChatJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final journalEvent =
    //     ref.watch(journalServiceProvider(journalType: JournalType.chat));
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    // final nowDate = DateTime.now();
    final chatsPrompt = ref.watch(chatsPromptNotifierProvider);
    final focusedDate = ref.watch(focusedDateProvider);
    final getMyJournal = ref.watch(getMyJournalByDateProvider(focusedDate));
    final chatFeedback = ref.watch(chatsFeedbackNotifierProvider);
    final scrollController = useScrollController(initialScrollOffset: 100);
    useScrollAnimateToBottom(
      scrollController: scrollController,
      scrollTriggerValue: getMyJournal,
    );
    ref.listen<AsyncValue<ChatsPromptState>>(
      chatsPromptNotifierProvider,
      (previous, next) {
        next.whenData((data) async {
          if (data is ChatsPromptData) {
            final userInput = ref.read(postTextInputProvider) ?? '';
            Print.cyan(userInput);

            await ref.read(myJournalStoreProvider.notifier).addHistory(
                focusedDate,
                History(
                    role: Role.assistant,
                    message: data.data.chatResponse.react));
          }
        });
      },
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
          padding: const EdgeInsets.fromLTRB(16, 57, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateHeaderDisplay(
                date: focusedDate,
                journalType: JournalType.chat,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final myJournalHistory =
                      ref.watch(getMyJournalHistoryByDateProvider(focusedDate));
                  return ListView.builder(

                      /// 없으면 공간생김
                      padding: const EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: myJournalHistory?.length ?? 0,
                      itemBuilder: (_, index) {
                        if (myJournalHistory?[index].role == Role.user) {
                          return UserChatItem(
                              message: myJournalHistory?[index].message ?? '');
                        } else if (myJournalHistory?[index].role ==
                            Role.assistant) {
                          return AssistantChatItem(
                              message: myJournalHistory?[index].message ?? '');
                        }
                        return const SizedBox.shrink();
                      });
                },
              ),
              chatsPrompt.when(
                data: (state) {
                  if (state is ChatsPromptData) {
                    if (state.data.chatResponse.canFeedback == true) {
                      return const Text('피드백가능!');
                    }
                    return const SizedBox.shrink();
                  } else if (state is ChatsPromptError) {
                    if (state.statusCode == 401) {
                      Print.red("다시 로그인해주세요");
                      return const Text("다시로그인해주세요");
                    }
                    if (state.statusCode == 500) {
                      Print.red(state.error);
                      return const Text("에러가 발생했습니다");
                    }
                    return Text('Error: ${state.error}',
                        style: textStyle.h4.copyWith(color: colors.error));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
              JournalTextField(
                  journalType: JournalType.chat,
                  submitClear: true,
                  date: focusedDate,
                  onSubmitted: () async {
                    // Print.red(ref.read(postTextInputProvider) ?? '');
                    final userInput = ref.read(postTextInputProvider) ?? '';
                    ref
                        .read(myJournalStoreProvider.notifier)
                        .createOrUpdateUserInput(
                            focusedDate, userInput, JournalType.chat);
                    await ref.read(myJournalStoreProvider.notifier).addHistory(
                        focusedDate,
                        History(role: Role.user, message: userInput));
                    final myJournalHistoryOnToday = ref
                        .read(getMyJournalHistoryByDateProvider(focusedDate));
                    await ref
                        .read(chatsPromptNotifierProvider.notifier)
                        .postPrompt(
                            body: ChatsRequestBody(
                                userInput: userInput,
                                histories: myJournalHistoryOnToday ?? []));
                  }),
              chatFeedback.when(
                data: (state) =>
                    buildChatFeedbackWidget(context, state, ref, getMyJournal),
                loading: () => buildChatFeedbackLoadingWidget(),
                error: (error, stack) => Text('Error: $error',
                    style: textStyle.h4.copyWith(color: colors.error)),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       ref
              //           .read(myJournalStoreProvider.notifier)
              //           .delete(focusedDate);
              //     },
              //     child: const Text("테스트삭제"))
            ],
          ),
        ));
  }
}
