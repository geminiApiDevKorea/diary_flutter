// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicDiary _$MusicDiaryFromJson(Map<String, dynamic> json) => MusicDiary(
      date: json['date'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$MusicDiaryToJson(MusicDiary instance) =>
    <String, dynamic>{
      'date': instance.date,
      'title': instance.title,
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

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

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
    final value = DiaryRespons.fromJson(_result.data!);
    return value;
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
