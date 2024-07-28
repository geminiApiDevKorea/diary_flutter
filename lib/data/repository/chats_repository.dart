import 'dart:convert';
import 'package:diary_flutter/data/model/diary/chats_result.dart';
import 'package:diary_flutter/data/model/diary/evaluated_prompt_content.dart';
import 'package:diary_flutter/data/model/diary/generated_feedback_content.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'chats_repository.g.dart';

@JsonSerializable()
class ChatsRequestBody {
  final String userInput;
  @JsonKey(name: 'history')
  final List<History> histories;
  Map<String, dynamic> toJson() => _$ChatsRequestBodyToJson(this);
  ChatsRequestBody({required this.userInput, required this.histories});
}

@JsonSerializable()
class ChatsFeedbackResponse {
  final ChatsResult result;

  ChatsFeedbackResponse({required this.result});

  GeneratedFeedbackContent get content {
    print(result.output.content);
    return GeneratedFeedbackContent.fromJson(
      jsonDecode(result.output.content) as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() => _$ChatsFeedbackResponseToJson(this);
  factory ChatsFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatsFeedbackResponseFromJson(json);
}

@JsonSerializable()
class ChatsPromptResponse {
  final ChatsResult result;

  ChatsPromptResponse({required this.result});

  EvaluatedPromptContent get content =>
      EvaluatedPromptContent.fromJson(jsonDecode(result.output.content));

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
    @Body() required ChatsRequestBody body,
  });

  @POST('/chats/prompt')
  Future<ChatsPromptResponse> postChatsPrompt({
    @Header('Authorization') required String bearerToken,
    @Body() required ChatsRequestBody body,
  });
}
