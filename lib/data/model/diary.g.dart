// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diary _$DiaryFromJson(Map<String, dynamic> json) => Diary(
      DateTime.parse(json['dateTime'] as String),
      json['content'] as String,
      $enumDecodeNullable(_$MoodsEnumMap, json['mood']),
      (json['playlist'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DiaryToJson(Diary instance) => <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'content': instance.content,
      'mood': _$MoodsEnumMap[instance.mood],
      'playlist': instance.playlist,
    };

const _$MoodsEnumMap = {
  Moods.happy: 'happy',
  Moods.sad: 'sad',
  Moods.angry: 'angry',
  Moods.neutral: 'neutral',
};
