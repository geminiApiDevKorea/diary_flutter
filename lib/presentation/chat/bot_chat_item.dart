import 'package:diary_flutter/data/model/chat.dart';
import 'package:flutter/material.dart';

class BotChatItem extends StatelessWidget {
  final Chat chat;
  const BotChatItem({
    required this.chat,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Row(
        textDirection: TextDirection.ltr,
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
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RichText(
                text: TextSpan(
                  text: chat.message,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
