// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsFeedbackBody _$ChatsFeedbackBodyFromJson(Map<String, dynamic> json) =>
    ChatsFeedbackBody(
      userInput: json['userInput'] as String,
      histories: (json['history'] as List<dynamic>)
          .map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatsFeedbackBodyToJson(ChatsFeedbackBody instance) =>
    <String, dynamic>{
      'userInput': instance.userInput,
      'history': instance.histories,
    };

DiaryMusicFeedbackResponse _$DiaryMusicFeedbackResponseFromJson(
        Map<String, dynamic> json) =>
    DiaryMusicFeedbackResponse(
      result: DiaryMusicFeedbackResult.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiaryMusicFeedbackResponseToJson(
        DiaryMusicFeedbackResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ChatsRepository implements ChatsRepository {
  _ChatsRepository(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<DiaryMusicFeedbackResponse> postChatsFeedback({
    required String bearerToken,
    required ChatsFeedbackBody body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DiaryMusicFeedbackResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'chats/feedback',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DiaryMusicFeedbackResponse.fromJson(_result.data!);
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
