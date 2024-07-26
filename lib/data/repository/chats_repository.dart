import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/song.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'chats_repository.g.dart';

@JsonSerializable()
class ChatsFeedbackBody {
  final String userInput;
  @JsonKey(name: 'history')
  final List<History> histories;
  Map<String, dynamic> toJson() => _$ChatsFeedbackBodyToJson(this);
  ChatsFeedbackBody({required this.userInput, required this.histories});
}

// TODO : ChatsContent, ChatsOutput, ChatsResult는 Data Model로 이동해야 합니다.
@JsonSerializable()
class ChatsContent {
  final String comment;
  final Song song;
  String get queryString => '${song.singer}, ${song.title}';
  ChatsContent({required this.comment, required this.song});

  factory ChatsContent.fromJson(Map<String, dynamic> json) =>
      _$ChatsContentFromJson(json);
  Map<String, dynamic> toJson() => _$ChatsContentToJson(this);
}

@JsonSerializable()
class ChatsOutput {
  final String messageType;
  final ChatsContent content;
  Map<String, dynamic> toJson() => _$ChatsOutputToJson(this);
  factory ChatsOutput.fromJson(Map<String, dynamic> json) =>
      _$ChatsOutputFromJson(json);
  ChatsOutput({required this.messageType, required this.content});
}

@JsonSerializable()
class ChatsResult {
  final ChatsOutput output;
  Map<String, dynamic> toJson() => _$ChatsResultToJson(this);
  factory ChatsResult.fromJson(Map<String, dynamic> json) =>
      _$ChatsResultFromJson(json);
  ChatsResult({required this.output});
}

@JsonSerializable()
class ChatsFeedbackResponse {
  ChatsContent get content => result.output.content;
  final ChatsResult result;
  Map<String, dynamic> toJson() => _$ChatsFeedbackResponseToJson(this);
  factory ChatsFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatsFeedbackResponseFromJson(json);
  ChatsFeedbackResponse({required this.result});
}

@RestApi()
abstract class ChatsRepository {
  factory ChatsRepository(Dio dio) = _ChatsRepository;

  @POST('chats/feedback')
  Future<ChatsFeedbackResponse> postChatsFeedback({
    @Header('Authorization') required String bearerToken,
    @Body() required ChatsFeedbackBody body,
  });
}
