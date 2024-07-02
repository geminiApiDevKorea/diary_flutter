import 'package:flutter/material.dart';

class ChatSubmitButton extends StatelessWidget {
  final bool isEnable;
  final VoidCallback onSubmit;
  const ChatSubmitButton({
    required this.isEnable,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isEnable ? onSubmit : null,
      icon: const Icon(
        Icons.send,
        color: Colors.white,
      ),
      label: const Text(
        'send',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
