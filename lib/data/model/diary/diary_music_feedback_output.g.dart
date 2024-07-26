// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_music_feedback_output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryMusicFeedbackOutput _$DiaryMusicFeedbackOutputFromJson(
        Map<String, dynamic> json) =>
    DiaryMusicFeedbackOutput(
      messageType: json['messageType'] as String,
      content: const StringDiaryMusicFeedbackContentConverter()
          .fromJson(json['content'] as String),
    );

Map<String, dynamic> _$DiaryMusicFeedbackOutputToJson(
        DiaryMusicFeedbackOutput instance) =>
    <String, dynamic>{
      'messageType': instance.messageType,
      'content': const StringDiaryMusicFeedbackContentConverter()
          .toJson(instance.content),
    };
