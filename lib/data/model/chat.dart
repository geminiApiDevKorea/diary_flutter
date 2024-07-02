import 'dart:math';

import 'package:diary_flutter/common/enums.dart';

class Chat {
  final Role role;
  final String message;
  final String? errorMessage;

  bool get isUser => role == Role.user;
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  const Chat({
    required this.role,
    required this.message,
    this.errorMessage,
  });

  factory Chat.fromMessage({required Role role, required String message}) {
    return Chat(role: role, message: message);
  }
  factory Chat.dummy(int index) {
    return Chat(
      role: Random().nextInt(2) == 0 ? Role.ai : Role.user,
      message: 'Hello, World! $index' * (Random().nextInt(5) + 1),
    );
  }

  Chat copyWithException(String errorMessage) {
    return Chat(role: role, message: message, errorMessage: errorMessage);
  }
}
