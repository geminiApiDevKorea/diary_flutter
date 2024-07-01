// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llm_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LLMFeedback _$LLMFeedbackFromJson(Map<String, dynamic> json) => LLMFeedback(
      json['comment'] as String,
      Song.fromJson(json['song'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LLMFeedbackToJson(LLMFeedback instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'song': instance.song,
    };
