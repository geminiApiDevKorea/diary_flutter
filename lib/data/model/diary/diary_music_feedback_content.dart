import 'dart:convert';

import 'package:diary_flutter/data/model/song.dart';
import 'package:json_annotation/json_annotation.dart';

part 'diary_music_feedback_content.g.dart';

class StringDiaryMusicFeedbackContentConverter
    implements JsonConverter<DiaryMusicFeedbackContent, String> {
  const StringDiaryMusicFeedbackContentConverter();

  @override
  DiaryMusicFeedbackContent fromJson(String json) {
    return DiaryMusicFeedbackContent.fromJson(
        jsonDecode(json) as Map<String, dynamic>);
  }

  @override
  String toJson(DiaryMusicFeedbackContent object) {
    return jsonEncode(object.toJson());
  }
}

@JsonSerializable()
class DiaryMusicFeedbackContent {
  final String comment;
  final Song song;
  String get queryString => '${song.singer}, ${song.title}';
  DiaryMusicFeedbackContent({required this.comment, required this.song});

  factory DiaryMusicFeedbackContent.fromJson(Map<String, dynamic> json) =>
      _$DiaryMusicFeedbackContentFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryMusicFeedbackContentToJson(this);
}
