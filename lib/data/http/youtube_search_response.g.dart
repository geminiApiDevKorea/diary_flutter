// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeThumbnail _$YoutubeThumbnailFromJson(Map<String, dynamic> json) =>
    YoutubeThumbnail(
      json['url'] as String,
    );

Map<String, dynamic> _$YoutubeThumbnailToJson(YoutubeThumbnail instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

YoutubeThumbnails _$YoutubeThumbnailsFromJson(Map<String, dynamic> json) =>
    YoutubeThumbnails(
      YoutubeThumbnail.fromJson(json['default'] as Map<String, dynamic>),
      YoutubeThumbnail.fromJson(json['medium'] as Map<String, dynamic>),
      YoutubeThumbnail.fromJson(json['high'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$YoutubeThumbnailsToJson(YoutubeThumbnails instance) =>
    <String, dynamic>{
      'default': instance.defaultThumbnail,
      'medium': instance.mediumThumbnail,
      'high': instance.highThumbnail,
    };

YoutubeSnippet _$YoutubeSnippetFromJson(Map<String, dynamic> json) =>
    YoutubeSnippet(
      json['title'] as String,
      json['description'] as String,
      YoutubeThumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$YoutubeSnippetToJson(YoutubeSnippet instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'thumbnails': instance.thumbnails,
    };

YoutubeId _$YoutubeIdFromJson(Map<String, dynamic> json) => YoutubeId(
      json['videoId'] as String,
    );

Map<String, dynamic> _$YoutubeIdToJson(YoutubeId instance) => <String, dynamic>{
      'videoId': instance.videoId,
    };

YoutubeItem _$YoutubeItemFromJson(Map<String, dynamic> json) => YoutubeItem(
      YoutubeId.fromJson(json['id'] as Map<String, dynamic>),
      YoutubeSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$YoutubeItemToJson(YoutubeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'snippet': instance.snippet,
    };

YoutubeSearchResponse _$YoutubeSearchResponseFromJson(
        Map<String, dynamic> json) =>
    YoutubeSearchResponse(
      (json['items'] as List<dynamic>)
          .map((e) => YoutubeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YoutubeSearchResponseToJson(
        YoutubeSearchResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
