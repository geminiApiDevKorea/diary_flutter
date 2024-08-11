import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/music.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'diary_repository.g.dart';

// DateTime ISO-8601 Formatter : 2024-08-21 > DateTime
class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String();
  }
}

@JsonSerializable()
class MusicDiary {
  @DateTimeConverter()
  final DateTime dateTime;
  final String title;
  final List<History> contents;
  final FeedbackType type;
  final Music music;

  String get musicThumbnailImageUrl => music.thumbnailUrl;

  MusicDiary({
    required this.dateTime,
    required this.title,
    required this.contents,
    required this.type,
    required this.music,
  });

  factory MusicDiary.fromJson(Map<String, dynamic> json) =>
      _$MusicDiaryFromJson(json);
  Map<String, dynamic> toJson() => _$MusicDiaryToJson(this);
}

@JsonSerializable()
class DiaryRespons {
  final List<MusicDiary> diary;

  DiaryRespons({
    required this.diary,
  });

  factory DiaryRespons.fromJson(Map<String, dynamic> json) =>
      _$DiaryResponsFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryResponsToJson(this);
}

@JsonSerializable()
class DiaryPostResponse {
  final String title;
  final String music;
  final String code;

  DiaryPostResponse({
    required this.title,
    required this.music,
    required this.code,
  });

  factory DiaryPostResponse.fromJson(Map<String, dynamic> json) =>
      _$DiaryPostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryPostResponseToJson(this);
}

@JsonSerializable()
class DailyDiary {
  final String dateTime;
  final String title;
  final List<History> contents;
  final FeedbackType type;
  final Music music;
  List<String>? tag;
  DailyDiary({
    required this.type,
    required this.dateTime,
    required this.title,
    required this.contents,
    required this.music,
    this.tag,
  });

  factory DailyDiary.fromJson(Map<String, dynamic> json) =>
      _$DailyDiaryFromJson(json);
  Map<String, dynamic> toJson() => _$DailyDiaryToJson(this);
}

@JsonSerializable()
class DiaryPostBody {
  final DailyDiary dailyDiary;
  DiaryPostBody({
    required this.dailyDiary,
  });
  factory DiaryPostBody.fromJson(Map<String, dynamic> json) =>
      _$DiaryPostBodyFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryPostBodyToJson(this);
}

@RestApi()
abstract class DiaryRepository {
  factory DiaryRepository(Dio dio) = _DiaryRepository;

  @GET('/diary')
  Future<DiaryRespons> getDiary({
    @Header('Authorization') required String bearerToken,
    @Query('month') String? yyyyMM,
    @Query('offset') String? yyyyMMdd,
    @Query('limit') int? limit,
  });

  @POST('/diary')
  Future<DiaryPostResponse> postDiary({
    @Header('Authorization') required String bearerToken,
    @Body() required DiaryPostBody body,
  });
}
