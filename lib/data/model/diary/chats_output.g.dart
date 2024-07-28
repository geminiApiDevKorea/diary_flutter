// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsOutput _$ChatsOutputFromJson(Map<String, dynamic> json) => ChatsOutput(
      messageType: json['messageType'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ChatsOutputToJson(ChatsOutput instance) =>
    <String, dynamic>{
      'messageType': instance.messageType,
      'content': instance.content,
    };
