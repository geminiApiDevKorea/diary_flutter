// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluated_prompt_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EvaluatedPromptContent _$EvaluatedPromptContentFromJson(
        Map<String, dynamic> json) =>
    EvaluatedPromptContent(
      canFeedback: json['canFeedback'] as bool,
      react: json['react'] as String,
    );

Map<String, dynamic> _$EvaluatedPromptContentToJson(
        EvaluatedPromptContent instance) =>
    <String, dynamic>{
      'canFeedback': instance.canFeedback,
      'react': instance.react,
    };
