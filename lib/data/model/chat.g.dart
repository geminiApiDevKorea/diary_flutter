// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      role: $enumDecode(_$RoleEnumMap, json['role']),
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      chatMetadata: json['chatMetadata'] == null
          ? null
          : ChatMetadata.fromJson(json['chatMetadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'role': _$RoleEnumMap[instance.role]!,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
      'chatMetadata': instance.chatMetadata,
    };

const _$RoleEnumMap = {
  Role.ai: 'ai',
  Role.user: 'user',
};
