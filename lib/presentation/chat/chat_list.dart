import 'package:diary_flutter/domain/provider/chats/count_chats.dart';
import 'package:diary_flutter/domain/provider/chats/get_chat.dart';
import 'package:diary_flutter/presentation/chat/bot_chat_item.dart';
import 'package:diary_flutter/presentation/chat/user_chat_item.dart';
import 'package:diary_flutter/presentation/utils/hooks/use_init_max_scroll_extent.dart';
import 'package:diary_flutter/presentation/utils/hooks/use_scroll_animate_to_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatList extends HookConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController(initialScrollOffset: 100);
    final chatCount = ref.watch(countChatsProvider);
    useInitMaxScrollExtent(scrollController: scrollController);
    useScrollAnimateToBottom(
      scrollController: scrollController,
      scrollTriggerValue: chatCount,
    );

    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: chatCount,
        itemBuilder: (context, index) {
          final chat = ref.watch(getChatProvider(index));
          return chat.isUser
              ? UserChatItem(chat: chat)
              : BotChatItem(chat: chat);
        },
      ),
    );
  }
}
