import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/presentation/chat/bot_chat_item.dart';
import 'package:diary_flutter/presentation/chat/user_chat_item.dart';
import 'package:diary_flutter/presentation/common/text_theme_getter_mixin.dart';
import 'package:flutter/material.dart';

class HomeChatTab extends StatelessWidget with TextThemeGetterMixin {
  const HomeChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              final chat = Chat.dummy(index);
              return chat.isUser
                  ? UserChatItem(chat: chat)
                  : BotChatItem(chat: chat);
            },
          ),
        ),
        Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your message',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('전송'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
