// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicDiary _$MusicDiaryFromJson(Map<String, dynamic> json) => MusicDiary(
      dateTime: const DateTimeConverter().fromJson(json['dateTime'] as String),
      title: json['title'] as String,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: $enumDecode(_$FeedbackTypeEnumMap, json['type']),
      music: Music.fromJson(json['music'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MusicDiaryToJson(MusicDiary instance) =>
    <String, dynamic>{
      'dateTime': const DateTimeConverter().toJson(instance.dateTime),
      'title': instance.title,
      'contents': instance.contents,
      'type': _$FeedbackTypeEnumMap[instance.type]!,
      'music': instance.music,
    };

const _$FeedbackTypeEnumMap = {
  FeedbackType.chat: 'chat',
  FeedbackType.post: 'post',
};

DiaryRespons _$DiaryResponsFromJson(Map<String, dynamic> json) => DiaryRespons(
      diary: (json['diary'] as List<dynamic>)
          .map((e) => MusicDiary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiaryResponsToJson(DiaryRespons instance) =>
    <String, dynamic>{
      'diary': instance.diary,
    };

DiaryPostResponse _$DiaryPostResponseFromJson(Map<String, dynamic> json) =>
    DiaryPostResponse(
      title: json['title'] as String,
      music: json['music'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$DiaryPostResponseToJson(DiaryPostResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'music': instance.music,
      'code': instance.code,
    };

DailyDiary _$DailyDiaryFromJson(Map<String, dynamic> json) => DailyDiary(
      type: $enumDecode(_$FeedbackTypeEnumMap, json['type']),
      dateTime: json['dateTime'] as String,
      title: json['title'] as String,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
      music: Music.fromJson(json['music'] as Map<String, dynamic>),
      tag: (json['tag'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DailyDiaryToJson(DailyDiary instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime,
      'title': instance.title,
      'contents': instance.contents,
      'type': _$FeedbackTypeEnumMap[instance.type]!,
      'music': instance.music,
      'tag': instance.tag,
    };

DiaryPostBody _$DiaryPostBodyFromJson(Map<String, dynamic> json) =>
    DiaryPostBody(
      dailyDiary:
          DailyDiary.fromJson(json['dailyDiary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiaryPostBodyToJson(DiaryPostBody instance) =>
    <String, dynamic>{
      'dailyDiary': instance.dailyDiary,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _DiaryRepository implements DiaryRepository {
  _DiaryRepository(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<DiaryRespons> getDiary({
    required String bearerToken,
    String? yyyyMM,
    String? yyyyMMdd,
    int? limit,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'month': yyyyMM,
      r'offset': yyyyMMdd,
      r'limit': limit,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DiaryRespons>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/diary',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DiaryRespons.fromJson(_result.data!);
    return _value;
  }

  @override
  Future<DiaryPostResponse> postDiary({
    required String bearerToken,
    required DiaryPostBody body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<DiaryPostResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/diary',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = DiaryPostResponse.fromJson(_result.data!);
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
