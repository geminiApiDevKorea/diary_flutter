// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AskFeedbackMetadata _$AskFeedbackMetadataFromJson(Map<String, dynamic> json) =>
    AskFeedbackMetadata(
      json['didAccept'] as bool?,
      json['askFeedbackMessage'] as String,
    );

Map<String, dynamic> _$AskFeedbackMetadataToJson(
        AskFeedbackMetadata instance) =>
    <String, dynamic>{
      'didAccept': instance.didAccept,
      'askFeedbackMessage': instance.askFeedbackMessage,
    };

ErrorMessageMetadata _$ErrorMessageMetadataFromJson(
        Map<String, dynamic> json) =>
    ErrorMessageMetadata(
      json['errorMessage'] as String,
    );

Map<String, dynamic> _$ErrorMessageMetadataToJson(
        ErrorMessageMetadata instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
    };
