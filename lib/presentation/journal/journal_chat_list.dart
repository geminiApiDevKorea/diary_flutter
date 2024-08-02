import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/presentation/journal/bot_chat_item.dart';

import 'package:diary_flutter/domain/provider/journal/journal_service.dart';
import 'package:diary_flutter/presentation/journal/user_chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalChatList extends HookConsumerWidget {
  const JournalChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    // final journalState =
    //     ref.watch(journalServiceProvider(journalType: JournalType.chat));

    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     if (scrollController.hasClients) {
    //       scrollController.animateTo(
    //         scrollController.position.maxScrollExtent,
    //         duration: const Duration(milliseconds: 300),
    //         curve: Curves.easeOut,
    //       );
    //     }
    //   });
    //   return null;
    // }, [journalState]);

    return Expanded(child: Container()
        // child: journalState.when(
        //   data: (state) {
        //     if (state is JournalLoaded && state.journal != null) {
        //       final chatHistory = state.journal!.history ?? [];
        //       return ListView.builder(
        //         controller: scrollController,
        //         itemCount: chatHistory.length,
        //         itemBuilder: (context, index) {
        //           final chat = chatHistory[index];
        //           return chat.role == Role.user
        //               ? UserChatItem(message: chat.message)
        //               : BotChatItem(message: chat.message);

        //       );
        //     } else {
        //       return const Center(child: Text('No chat history available'));
        //     }
        //   },
        //   loading: () => const Center(child: CircularProgressIndicator()),
        //   error: (error, stack) => Center(child: Text('Error: $error')),
        );
  }
}
