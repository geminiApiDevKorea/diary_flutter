import 'package:diary_flutter/data/model/song.dart';
import 'package:json_annotation/json_annotation.dart';

part 'llm_feedback.g.dart';

@JsonSerializable()
class LLMFeedback {
  final String comment;
  final Song song;
  LLMFeedback(this.comment, this.song);

  factory LLMFeedback.fromJson(Map<String, dynamic> json) =>
      _$LLMFeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$LLMFeedbackToJson(this);
}
