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

@RestApi()
abstract class ChatsRepository {
  factory ChatsRepository(Dio dio) = _ChatsRepository;

  @POST('/chats/feedback')
  Future<dynamic> postChatsFeedback({
    @Header('Authorization') required String bearerToken,
    @Body() required ChatsFeedbackBody body,
  });
}
