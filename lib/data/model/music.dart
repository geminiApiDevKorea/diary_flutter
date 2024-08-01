import 'package:json_annotation/json_annotation.dart';

part 'music.g.dart';

@JsonSerializable()
class Music {
  final String id;
  final String url;
  final String title;
  final String description;
  final String thumbnailUrl;

  Music({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  factory Music.fromJson(Map<String, dynamic> json) => _$MusicFromJson(json);
  Map<String, dynamic> toJson() => _$MusicToJson(this);

  @override
  String toString() {
    return 'Music(id: $id, url: $url, title: $title, description: $description, thumbnailUrl: $thumbnailUrl)';
  }
}
