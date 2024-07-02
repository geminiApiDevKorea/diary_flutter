import 'package:diary_flutter/data/model/chat.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;
  const ChatItem({
    required this.chat,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.0 + (chat.isUser ? 50 : 0),
        right: 8.0,
        top: 16.0,
        bottom: 16.0,
      ),
      child: Row(
        textDirection: chat.isUser ? TextDirection.rtl : TextDirection.ltr,
        children: [
          if (!chat.isUser)
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
                color: chat.isUser
                    ? Colors.grey[200]
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RichText(
                text: TextSpan(
                  text: chat.message,
                  style: TextStyle(
                    decoration: chat.hasError
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 18,
                    color: chat.hasError
                        ? Colors.grey[300]
                        : (chat.isUser ? Colors.blue[700] : Colors.white),
                  ),
                  children: [
                    if (chat.hasError)
                      TextSpan(
                        text: '\n${chat.errorMessage}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
