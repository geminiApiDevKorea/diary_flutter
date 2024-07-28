import 'package:json_annotation/json_annotation.dart';
part 'chats_output.g.dart';

@JsonSerializable()
class ChatsOutput {
  final String messageType;
  final String content;

  ChatsOutput({required this.messageType, required this.content});

  Map<String, dynamic> toJson() => _$ChatsOutputToJson(this);
  factory ChatsOutput.fromJson(Map<String, dynamic> json) =>
      _$ChatsOutputFromJson(json);
}
