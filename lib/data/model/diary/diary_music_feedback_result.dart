import 'package:diary_flutter/data/model/diary/diary_music_feedback_output.dart';
import 'package:json_annotation/json_annotation.dart';

part 'diary_music_feedback_result.g.dart';

@JsonSerializable()
class DiaryMusicFeedbackResult {
  final DiaryMusicFeedbackOutput output;
  Map<String, dynamic> toJson() => _$DiaryMusicFeedbackResultToJson(this);
  factory DiaryMusicFeedbackResult.fromJson(Map<String, dynamic> json) =>
      _$DiaryMusicFeedbackResultFromJson(json);
  DiaryMusicFeedbackResult({required this.output});
}
