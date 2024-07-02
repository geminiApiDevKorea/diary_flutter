import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/presentation/chat/chat_item.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: 1,
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index) {
        return const ChatItem(
          chat: Chat(
            role: Role.user,
            message: 'Hello, World!',
          ),
        );
      },
    );
  }
}
