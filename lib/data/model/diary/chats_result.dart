import 'package:diary_flutter/data/model/diary/chats_output.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chats_result.g.dart';

@JsonSerializable()
class ChatsResult {
  final ChatsOutput output;

  ChatsResult({required this.output});

  Map<String, dynamic> toJson() => _$ChatsResultToJson(this);
  factory ChatsResult.fromJson(Map<String, dynamic> json) =>
      _$ChatsResultFromJson(json);
}
