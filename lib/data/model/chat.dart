import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/chat_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final Role role;
  final String message;
  final DateTime createdAt;
  ChatMetadata? chatMetadata;

  bool get isUser => role == Role.user;

  bool get isAcceptable {
    var metaData = chatMetadata;
    if (metaData is AskFeedbackMetadata) {
      return metaData.didAccept == null;
    } else {
      return false;
    }
  }

  Chat({
    required this.role,
    required this.message,
    required this.createdAt,
    this.chatMetadata,
  });

  factory Chat.user(String message) => Chat(
        role: Role.user,
        message: message,
        createdAt: DateTime.now(),
      );

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);

  Chat copyWith({
    Role? role,
    String? message,
    DateTime? createdAt,
    ChatMetadata? chatMetadata,
  }) {
    return Chat(
      role: role ?? this.role,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      chatMetadata: chatMetadata ?? this.chatMetadata,
    );
  }
}
