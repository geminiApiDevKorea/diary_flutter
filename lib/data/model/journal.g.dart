// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicJournal _$MusicJournalFromJson(Map<String, dynamic> json) => MusicJournal(
      createdAt: DateTime.parse(json['createdAt'] as String),
      title: json['title'] as String,
      music: json['music'] == null
          ? null
          : Music.fromJson(json['music'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MusicJournalToJson(MusicJournal instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'title': instance.title,
      'music': instance.music?.toJson(),
      'tags': instance.tags,
    };

PostJournal _$PostJournalFromJson(Map<String, dynamic> json) => PostJournal(
      createdAt: DateTime.parse(json['createdAt'] as String),
      title: json['title'] as String,
      music: json['music'] == null
          ? null
          : Music.fromJson(json['music'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      post: json['post'] as String?,
    );

Map<String, dynamic> _$PostJournalToJson(PostJournal instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'title': instance.title,
      'music': instance.music?.toJson(),
      'tags': instance.tags,
      'post': instance.post,
    };
