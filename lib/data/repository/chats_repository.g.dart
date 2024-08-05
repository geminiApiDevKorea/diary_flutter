// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsRequestBody _$ChatsRequestBodyFromJson(Map<String, dynamic> json) =>
    ChatsRequestBody(
      userInput: json['userInput'] as String,
      histories: (json['history'] as List<dynamic>)
          .map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatsRequestBodyToJson(ChatsRequestBody instance) =>
    <String, dynamic>{
      'userInput': instance.userInput,
      'history': instance.histories,
    };

ChatsFeedbackResponse _$ChatsFeedbackResponseFromJson(
        Map<String, dynamic> json) =>
    ChatsFeedbackResponse(
      feedbackResponse: FeedbackResponse.fromJson(
          json['chatPromptResponse'] as Map<String, dynamic>),
      music: Music.fromJson(json['music'] as Map<String, dynamic>),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$ChatsFeedbackResponseToJson(
        ChatsFeedbackResponse instance) =>
    <String, dynamic>{
      'chatPromptResponse': instance.feedbackResponse,
      'music': instance.music,
      'code': instance.code,
    };

FeedbackResponse _$FeedbackResponseFromJson(Map<String, dynamic> json) =>
    FeedbackResponse(
      comment: json['comment'] as String,
      song: Song.fromJson(json['song'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedbackResponseToJson(FeedbackResponse instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'song': instance.song,
    };

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
      canFeedback: json['canFeedback'] as bool,
      react: json['react'] as String,
    );

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'canFeedback': instance.canFeedback,
      'react': instance.react,
    };

ChatsPromptResponse _$ChatsPromptResponseFromJson(Map<String, dynamic> json) =>
    ChatsPromptResponse(
      chatResponse: ChatResponse.fromJson(
          json['chatPromptResponse'] as Map<String, dynamic>),
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$ChatsPromptResponseToJson(
        ChatsPromptResponse instance) =>
    <String, dynamic>{
      'chatPromptResponse': instance.chatResponse,
      'code': instance.code,
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
  Future<ChatsFeedbackResponse> postChatsFeedback({
    required String bearerToken,
    required FeedbackType type,
    required ChatsRequestBody body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'type': type.name};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChatsFeedbackResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/chats/feedback',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ChatsFeedbackResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ChatsPromptResponse> postChatsPrompt({
    required String bearerToken,
    required ChatsRequestBody body,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChatsPromptResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/chats/prompt',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ChatsPromptResponse.fromJson(_result.data!);
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
