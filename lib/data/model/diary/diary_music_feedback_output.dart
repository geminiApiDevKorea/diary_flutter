import 'package:diary_flutter/data/model/diary/diary_music_feedback_content.dart';
import 'package:json_annotation/json_annotation.dart';

part 'diary_music_feedback_output.g.dart';

@JsonSerializable()
class DiaryMusicFeedbackOutput {
  final String messageType;
  @StringDiaryMusicFeedbackContentConverter()
  final DiaryMusicFeedbackContent content;
  Map<String, dynamic> toJson() => _$DiaryMusicFeedbackOutputToJson(this);
  factory DiaryMusicFeedbackOutput.fromJson(Map<String, dynamic> json) =>
      _$DiaryMusicFeedbackOutputFromJson(json);
  DiaryMusicFeedbackOutput({required this.messageType, required this.content});
}
