import 'dart:convert';
import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/diary/chats_result.dart';
import 'package:diary_flutter/data/model/diary/evaluated_prompt_content.dart';
import 'package:diary_flutter/data/model/diary/generated_feedback_content.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/music.dart';
import 'package:diary_flutter/data/model/song.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'chats_repository.g.dart';

@JsonSerializable()
class ChatsRequestBody {
  final String userInput;
  @JsonKey(name: 'history')
  final List<History> histories;

  ChatsRequestBody({required this.userInput, required this.histories});

  Map<String, dynamic> toJson() => _$ChatsRequestBodyToJson(this);

  @override
  String toString() {
    return 'ChatsRequestBody(userInput: $userInput, histories: $histories)';
  }
}

@JsonSerializable()
class ChatsFeedbackResponse {
  ChatPromptResponse chatPromptResponse;
  Music music;
  int code;

  ChatsFeedbackResponse({
    required this.chatPromptResponse,
    required this.music,
    required this.code,
  });

  factory ChatsFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatsFeedbackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatsFeedbackResponseToJson(this);

  ChatsFeedbackResponse copyWith({
    ChatPromptResponse? chatPromptResponse,
    Music? music,
    int? code,
  }) {
    return ChatsFeedbackResponse(
      chatPromptResponse: chatPromptResponse ?? this.chatPromptResponse,
      music: music ?? this.music,
      code: code ?? this.code,
    );
  }

  @override
  String toString() {
    return 'ChatsFeedbackResponse(chatPromptResponse: $chatPromptResponse, music: $music, code: $code)';
  }
}

@JsonSerializable()
class ChatPromptResponse {
  String comment;
  Song song;

  ChatPromptResponse({
    required this.comment,
    required this.song,
  });

  factory ChatPromptResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatPromptResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatPromptResponseToJson(this);

  ChatPromptResponse copyWith({
    String? comment,
    Song? song,
  }) {
    return ChatPromptResponse(
      comment: comment ?? this.comment,
      song: song ?? this.song,
    );
  }

  @override
  String toString() {
    return 'ChatPromptResponse(comment: $comment, song: $song)';
  }
}

@JsonSerializable()
class ChatResponse {
  final ChatsResult result;

  ChatResponse({required this.result});

  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);
}

@JsonSerializable()
class ChatsPromptResponse {
  final ChatResponse chatResponse;

  ChatsPromptResponse({required this.chatResponse});

  EvaluatedPromptContent get content => EvaluatedPromptContent.fromJson(
      jsonDecode(chatResponse.result.output.content));

  Map<String, dynamic> toJson() => _$ChatsPromptResponseToJson(this);
  factory ChatsPromptResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatsPromptResponseFromJson(json);
}

@RestApi()
abstract class ChatsRepository {
  factory ChatsRepository(Dio dio) = _ChatsRepository;

  @POST('/chats/feedback')
  Future<ChatsFeedbackResponse> postChatsFeedback({
    @Header('Authorization') required String bearerToken,
    @Query('type') required FeedbackType type,
    @Body() required ChatsRequestBody body,
  });

  @POST('/chats/prompt')
  Future<ChatsPromptResponse> postChatsPrompt({
    @Header('Authorization') required String bearerToken,
    @Body() required ChatsRequestBody body,
  });
}
