// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_feedback_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratedFeedbackContent _$GeneratedFeedbackContentFromJson(
        Map<String, dynamic> json) =>
    GeneratedFeedbackContent(
      comment: json['comment'] as String,
      song: Song.fromJson(json['song'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneratedFeedbackContentToJson(
        GeneratedFeedbackContent instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'song': instance.song,
    };
