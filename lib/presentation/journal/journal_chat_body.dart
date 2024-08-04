import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/chats/chats_prompt_notifier.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/journal/assistant_chat_item.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/presentation/journal/provider/journal_service.dart';
import 'package:diary_flutter/presentation/journal/journal_text_field.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:diary_flutter/presentation/journal/user_chat_item.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

class ChatJournalBody extends ConsumerWidget {
  const ChatJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final journalEvent =
    //     ref.watch(journalServiceProvider(journalType: JournalType.chat));
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final nowDate = DateTime.now();
    final chatsPrompt = ref.watch(chatsPromptNotifierProvider);
    ref.listen<AsyncValue<ChatsPromptState>>(
      chatsPromptNotifierProvider,
      (previous, next) {
        next.whenData((data) async {
          if (data is ChatsPromptData) {
            final userInput = ref.read(postTextInputProvider) ?? '';
            Print.cyan(userInput);

            await ref.read(myJournalStoreProvider.notifier).addHistory(
                nowDate,
                History(
                    role: Role.assistant,
                    message: data.data.chatResponse.react));
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
              Consumer(
                builder: (context, ref, child) {
                  final myJournalHistory =
                      ref.watch(getMyJournalHistoryByDateProvider(nowDate));
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
                  submitClear: true,
                  date: nowDate,
                  onSubmitted: () async {
                    // Print.red(ref.read(postTextInputProvider) ?? '');
                    final userInput = ref.read(postTextInputProvider) ?? '';

                    await ref.read(myJournalStoreProvider.notifier).addHistory(
                        nowDate, History(role: Role.user, message: userInput));
                    final myJournalHistoryOnToday =
                        ref.read(getMyJournalHistoryByDateProvider(nowDate));
                    await ref
                        .read(chatsPromptNotifierProvider.notifier)
                        .postPrompt(
                            body: ChatsRequestBody(
                                userInput: userInput,
                                histories: myJournalHistoryOnToday ?? []));
                  }),
              ElevatedButton(
                  onPressed: () {
                    ref.read(myJournalStoreProvider.notifier).delete(nowDate);
                  },
                  child: const Text("테스트삭제"))
            ],
          ),
        ));
  }
}
