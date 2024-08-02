import 'package:diary_flutter/data/model/history.dart';
import 'package:flutter/material.dart';

class UserChatItem extends StatelessWidget {
  final String message;

  const UserChatItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(message),
    );
  }
}
