import 'package:diary_flutter/common/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'diary.g.dart';

@JsonSerializable()
class Diary {
  static int maxLength = 100;

  final DateTime dateTime;
  final String content;
  final Moods? mood;
  final List<String>? playlist;

  int get contentLength => content.length;
  bool get isEmpty => content.isEmpty;

  Diary(this.dateTime, this.content, this.mood, this.playlist);

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryToJson(this);

  Diary copyWith({
    DateTime? dateTime,
    String? content,
    Moods? mood,
    List<String>? playlist,
  }) =>
      Diary(
        dateTime ?? this.dateTime,
        content ?? this.content,
        mood ?? this.mood,
        playlist ?? this.playlist,
      );
}
