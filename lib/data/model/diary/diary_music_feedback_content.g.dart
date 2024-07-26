// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_music_feedback_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryMusicFeedbackContent _$DiaryMusicFeedbackContentFromJson(
        Map<String, dynamic> json) =>
    DiaryMusicFeedbackContent(
      comment: json['comment'] as String,
      song: Song.fromJson(json['song'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiaryMusicFeedbackContentToJson(
        DiaryMusicFeedbackContent instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'song': instance.song,
    };
