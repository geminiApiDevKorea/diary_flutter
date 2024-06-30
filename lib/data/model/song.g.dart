// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      json['title'] as String,
      json['singer'] as String,
      json['reason'] as String,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'singer': instance.singer,
      'title': instance.title,
      'reason': instance.reason,
    };
