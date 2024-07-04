import 'package:diary_flutter/data/model/chat.dart';
import 'package:flutter/material.dart';

class UserChatItem extends StatelessWidget {
  final Chat chat;
  const UserChatItem({
    required this.chat,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 58.0,
        right: 8.0,
        top: 16.0,
        bottom: 16.0,
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
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
                    color: chat.hasError ? Colors.grey[300] : Colors.blue[700],
                  ),
                  children: [
                    if (chat.hasError)
                      TextSpan(
                        text: '\n${chat.errorMessage}',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.red,
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
