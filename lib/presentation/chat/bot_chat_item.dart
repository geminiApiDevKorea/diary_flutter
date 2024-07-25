import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback.dart';
import 'package:diary_flutter/domain/provider/chats/stored_chats.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BotChatItem extends ConsumerWidget {
  final Chat chat;
  const BotChatItem({
    required this.chat,
    super.key,
  });

  _onAccept(WidgetRef ref, bool isAccept) {
    ref.read(storedChatsProvider.notifier).accept(chat, isAccept);
    var storedChats = ref.read(storedChatsProvider);
    ref.read(chatsFeedbackProvider(storedChats)).when(
          data: (value) => print(value),
          loading: () => print('chat feedback loading'),
          error: (error, stackTrace) => print(error),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(
              Icons.smart_toy_outlined,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SelectableText(
                    chat.message,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (chat.isAcceptable) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _onAccept(ref, false),
                        child: const Text('No'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => _onAccept(ref, true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
