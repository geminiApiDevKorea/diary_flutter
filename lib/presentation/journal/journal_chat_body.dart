import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:diary_flutter/domain/provider/auth/get_my_name.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/chats/chats_prompt_notifier.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/gen/assets.gen.dart';
import 'package:diary_flutter/presentation/journal/assistant_chat_item.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/presentation/journal/journal_feedback_widget.dart';
import 'package:diary_flutter/presentation/journal/journal_text_field.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:diary_flutter/presentation/journal/user_chat_item.dart';
import 'package:diary_flutter/presentation/journal/journal_screen.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

class ChatJournalBody extends JournalBody {
  const ChatJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final journalEvent =
    //     ref.watch(journalServiceProvider(feedbackType: FeedbackType.chat));
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    // final nowDate = DateTime.now();
    final chatsPrompt = ref.watch(chatsPromptNotifierProvider);
    final focusedDate = ref.watch(focusedDateProvider);
    final getMyJournal = ref.watch(getMyJournalByDateProvider(focusedDate));
    final chatFeedback = ref.watch(chatsFeedbackNotifierProvider);
    final scrollController = useScrollController(initialScrollOffset: 0);
    final myName = ref.read(getMyNameProvider);
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
          // margin: const EdgeInsets.only(bottom: 20),
          color: colors.grayScale90,
          padding: const EdgeInsets.fromLTRB(16, 57, 16, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateHeaderDisplay(
                date: focusedDate,
                feedbackType: FeedbackType.chat,
              ),
              Text(
                'Hi $myName\nHow was your day?',
                style: textStyle.paragraph
                    .withColor(colors.grayScale60)
                    .withHeight(1.2),
              ),
              const SizedBox(height: 10),
              Divider(
                color: colors.grayScale80,
                thickness: 1,
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
                  data: (data) {
                    return const SizedBox.shrink();
                  },
                  error: (error, stack) {
                    return const SizedBox.shrink();
                  },
                  loading: () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 18,
                            child: Assets.lotties.typingIndicator.lottie(
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Divider(
                          //   color: colors.grayScale80,
                          //   thickness: 1,
                          // ),
                        ],
                      )),
              // chatsPrompt.when(
              //   data: (state) {
              //     if (state is ChatsPromptData) {
              //       if (state.data.chatResponse.canFeedback == true) {
              //         return const Text('피드백가능!');
              //       }
              //       return const SizedBox.shrink();
              //     } else if (state is ChatsPromptError) {
              //       if (state.statusCode == 401) {
              //         Print.red("다시 로그인해주세요");
              //         return const Text("다시로그인해주세요");
              //       }
              //       if (state.statusCode == 500) {
              //         Print.red(state.error);
              //         return const Text("에러가 발생했습니다");
              //       }
              //       return Text('Error: ${state.error}',
              //           style: textStyle.h4.copyWith(color: colors.error));
              //     } else {
              //       return const SizedBox.shrink();
              //     }
              //   },
              //   loading: () => const Center(child: CircularProgressIndicator()),
              //   error: (error, stack) => Center(child: Text('Error: $error')),
              // ),
              JournalTextField(
                  feedbackType: FeedbackType.chat,
                  submitClear: true,
                  date: focusedDate,
                  onSubmitted: () async {
                    // Print.red(ref.read(postTextInputProvider) ?? '');
                    final userInput = ref.read(postTextInputProvider) ?? '';
                    if (userInput.isEmpty) {
                      return;
                    }
                    ref
                        .read(myJournalStoreProvider.notifier)
                        .createOrUpdateUserInput(
                            focusedDate, userInput, FeedbackType.chat);
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
                data: (state) => ChatFeedbackWidget(
                  state: state,
                  myJournal: getMyJournal,
                ),
                loading: () => const ChatFeedbackLoadingWidget(),
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
