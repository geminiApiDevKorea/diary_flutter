import 'package:diary_flutter/data/model/diary/diary_music_feedback_content.dart';
import 'package:diary_flutter/data/model/diary/diary_music_feedback_result.dart';
import 'package:diary_flutter/data/model/history.dart';
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

@JsonSerializable()
class DiaryMusicFeedbackResponse {
  DiaryMusicFeedbackContent get content => result.output.content;
  final DiaryMusicFeedbackResult result;
  Map<String, dynamic> toJson() => _$DiaryMusicFeedbackResponseToJson(this);
  factory DiaryMusicFeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$DiaryMusicFeedbackResponseFromJson(json);
  DiaryMusicFeedbackResponse({required this.result});
}

@RestApi()
abstract class ChatsRepository {
  factory ChatsRepository(Dio dio) = _ChatsRepository;

  @POST('chats/feedback')
  Future<DiaryMusicFeedbackResponse> postChatsFeedback({
    @Header('Authorization') required String bearerToken,
    @Body() required ChatsFeedbackBody body,
  });
}
