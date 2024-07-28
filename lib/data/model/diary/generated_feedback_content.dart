import 'package:diary_flutter/data/model/song.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated_feedback_content.g.dart';

@JsonSerializable()
class GeneratedFeedbackContent {
  final String comment;
  final Song song;
  String get queryString => '${song.singer}, ${song.title}';

  GeneratedFeedbackContent({required this.comment, required this.song});

  factory GeneratedFeedbackContent.fromJson(Map<String, dynamic> json) =>
      _$GeneratedFeedbackContentFromJson(json);
  Map<String, dynamic> toJson() => _$GeneratedFeedbackContentToJson(this);
}
