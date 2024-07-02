import 'package:flutter/material.dart';

class ChatInputTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback onSubmit;
  const ChatInputTextField({
    required this.textEditingController,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            onSubmit();
          }
        },
        controller: textEditingController,
        decoration: const InputDecoration(
          hintText: 'Type a message',
        ),
      ),
    );
  }
}
