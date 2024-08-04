import 'package:json_annotation/json_annotation.dart';

part 'song.g.dart';

@JsonSerializable()
class Song {
  final String singer;
  final String title;
  final String reason;

  Song(this.title, this.singer, this.reason);

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
  Map<String, dynamic> toJson() => _$SongToJson(this);

  @override
  String toString() {
    return 'Song(title: $title, singer: $singer, reason: $reason)';
  }
}
