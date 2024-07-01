import 'package:json_annotation/json_annotation.dart';

part 'youtube_search_response.g.dart';

@JsonSerializable()
class YoutubeThumbnail {
  final String url;
  YoutubeThumbnail(this.url);

  factory YoutubeThumbnail.fromJson(Map<String, dynamic> json) =>
      _$YoutubeThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$YoutubeThumbnailToJson(this);
}

@JsonSerializable()
class YoutubeThumbnails {
  @JsonKey(name: 'default')
  final YoutubeThumbnail defaultThumbnail;

  @JsonKey(name: 'medium')
  final YoutubeThumbnail mediumThumbnail;

  @JsonKey(name: 'high')
  final YoutubeThumbnail highThumbnail;
  YoutubeThumbnails(
      this.defaultThumbnail, this.mediumThumbnail, this.highThumbnail);

  factory YoutubeThumbnails.fromJson(Map<String, dynamic> json) =>
      _$YoutubeThumbnailsFromJson(json);
  Map<String, dynamic> toJson() => _$YoutubeThumbnailsToJson(this);
}

@JsonSerializable()
class YoutubeSnippet {
  final String title;
  final String description;
  final YoutubeThumbnails thumbnails;
  YoutubeSnippet(this.title, this.description, this.thumbnails);

  factory YoutubeSnippet.fromJson(Map<String, dynamic> json) =>
      _$YoutubeSnippetFromJson(json);
  Map<String, dynamic> toJson() => _$YoutubeSnippetToJson(this);
}

@JsonSerializable()
class YoutubeId {
  final String videoId;
  YoutubeId(this.videoId);

  factory YoutubeId.fromJson(Map<String, dynamic> json) =>
      _$YoutubeIdFromJson(json);
  Map<String, dynamic> toJson() => _$YoutubeIdToJson(this);
}

@JsonSerializable()
class YoutubeItem {
  String get videoId => id.videoId;
  String get videoUrl => 'https://www.youtube.com/watch?v=$videoId';
  String get thumbnailUrl => snippet.thumbnails.highThumbnail.url;

  final YoutubeId id;
  final YoutubeSnippet snippet;
  YoutubeItem(this.id, this.snippet);
  factory YoutubeItem.fromJson(Map<String, dynamic> json) =>
      _$YoutubeItemFromJson(json);
  Map<String, dynamic> toJson() => _$YoutubeItemToJson(this);
}

@JsonSerializable()
class YoutubeSearchResponse {
  final List<YoutubeItem> items;
  YoutubeSearchResponse(this.items);

  factory YoutubeSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$YoutubeSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$YoutubeSearchResponseToJson(this);
}
