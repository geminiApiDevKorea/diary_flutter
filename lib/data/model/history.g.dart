// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      role: $enumDecode(_$RoleEnumMap, json['role']),
      message: json['message'] as String,
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'role': _$RoleEnumMap[instance.role]!,
      'message': instance.message,
    };

const _$RoleEnumMap = {
  Role.assistant: 'assistant',
  Role.user: 'user',
};
