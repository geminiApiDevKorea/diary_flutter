import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'diary_repository.g.dart';

@JsonSerializable()
class MusicDiary {
  final String date;
  final String title;

  MusicDiary({
    required this.date,
    required this.title,
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

@RestApi()
abstract interface class DiaryRepository {
  factory DiaryRepository(Dio dio) = _DiaryRepository;

  @GET('/diary')
  Future<DiaryRespons> getDiary({
    @Header('Authorization') required String bearerToken,
    @Query('month') String? yyyyMM,
    @Query('offset') String? yyyyMMdd,
    @Query('limit') int? limit,
  });
}
