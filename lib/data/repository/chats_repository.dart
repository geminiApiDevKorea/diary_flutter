import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/music.dart';
import 'package:diary_flutter/data/model/song.dart';
import 'package:dio/dio.dart';
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
  @JsonKey(name: 'chatPromptResponse')
  FeedbackResponse feedbackResponse;
  Music music;
  int code;

  ChatsFeedbackResponse({
    required this.feedbackResponse,
    required this.music,
    required this.code,
  });

  factory ChatsFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatsFeedbackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatsFeedbackResponseToJson(this);

  ChatsFeedbackResponse copyWith({
    FeedbackResponse? feedbackResponse,
    Music? music,
    int? code,
  }) {
    return ChatsFeedbackResponse(
      feedbackResponse: feedbackResponse ?? this.feedbackResponse,
      music: music ?? this.music,
      code: code ?? this.code,
    );
  }

  @override
  String toString() {
    return 'ChatsFeedbackResponse(feedbackResponse: $feedbackResponse, music: $music, code: $code)';
  }
}

@JsonSerializable()
class FeedbackResponse {
  final String comment;
  final Song song;

  FeedbackResponse({required this.comment, required this.song});

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedbackResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackResponseToJson(this);

  @override
  String toString() {
    return 'FeedbackResponse(comment: $comment, song: $song)';
  }
}

@JsonSerializable()
class ChatResponse {
  final bool canFeedback;
  final String react;

  ChatResponse({required this.canFeedback, required this.react});

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);

  @override
  String toString() {
    return 'ChatResponse(canFeedback: $canFeedback, react: $react)';
  }
}

// @JsonSerializable()
// class ChatResponse {
//   final ChatsResult result;

//   ChatResponse({required this.result});

//   Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
//   factory ChatResponse.fromJson(Map<String, dynamic> json) =>
//       _$ChatResponseFromJson(json);
// }

@JsonSerializable()
class ChatsPromptResponse {
  @JsonKey(name: 'chatPromptResponse')
  final ChatResponse chatResponse;
  final int code;

  ChatsPromptResponse({required this.chatResponse, required this.code});

  // EvaluatedPromptContent get content => EvaluatedPromptContent.fromJson(
  //     jsonDecode(chatPromptResponse.result.output.content));

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
