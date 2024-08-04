// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Journal _$JournalFromJson(Map<String, dynamic> json) => Journal(
      title: json['title'] as String?,
      idToken: json['idToken'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userInput: json['userInput'] as String?,
      music: json['music'] == null
          ? null
          : Music.fromJson(json['music'] as Map<String, dynamic>),
      song: json['song'] == null
          ? null
          : Song.fromJson(json['song'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
      journalType: $enumDecode(_$JournalTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$JournalToJson(Journal instance) => <String, dynamic>{
      'title': instance.title,
      'idToken': instance.idToken,
      'createdAt': instance.createdAt.toIso8601String(),
      'userInput': instance.userInput,
      'music': instance.music?.toJson(),
      'song': instance.song?.toJson(),
      'tags': instance.tags,
      'history': instance.history.map((e) => e.toJson()).toList(),
      'type': _$JournalTypeEnumMap[instance.journalType]!,
    };

const _$JournalTypeEnumMap = {
  JournalType.post: 'post',
  JournalType.chat: 'chat',
};
