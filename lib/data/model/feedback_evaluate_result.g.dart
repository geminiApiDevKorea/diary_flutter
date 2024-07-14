// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_evaluate_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackEvaluateResult _$FeedbackEvaluateResultFromJson(
        Map<String, dynamic> json) =>
    FeedbackEvaluateResult(
      json['canFeedback'] as bool,
      json['react'] as String,
    );

Map<String, dynamic> _$FeedbackEvaluateResultToJson(
        FeedbackEvaluateResult instance) =>
    <String, dynamic>{
      'canFeedback': instance.canFeedback,
      'react': instance.react,
    };
