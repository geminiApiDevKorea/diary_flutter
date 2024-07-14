import 'package:json_annotation/json_annotation.dart';

part 'chat_metadata.g.dart';

abstract class ChatMetadata {
  ChatMetadata();
  factory ChatMetadata.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('askFeedbackMessage')) {
      return AskFeedbackMetadata.fromJson(json);
    } else if (json.containsKey('errorMessage')) {
      return ErrorMessageMetadata.fromJson(json);
    } else {
      throw Exception('Unknown metadata type');
    }
  }

  Map<String, dynamic> toJson() {
    if (this is AskFeedbackMetadata) {
      return (this as AskFeedbackMetadata).toJson();
    } else if (this is ErrorMessageMetadata) {
      return (this as ErrorMessageMetadata).toJson();
    } else {
      throw Exception('Unknown metadata type');
    }
  }
}

@JsonSerializable()
class AskFeedbackMetadata extends ChatMetadata {
  final bool? didAccept;
  final String askFeedbackMessage;

  AskFeedbackMetadata(this.didAccept, this.askFeedbackMessage);

  factory AskFeedbackMetadata.fromJson(Map<String, dynamic> json) =>
      _$AskFeedbackMetadataFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AskFeedbackMetadataToJson(this);

  AskFeedbackMetadata copyWith({bool? didAccept, String? askFeedbackMessage}) {
    return AskFeedbackMetadata(
      didAccept ?? this.didAccept,
      askFeedbackMessage ?? this.askFeedbackMessage,
    );
  }
}

@JsonSerializable()
class ErrorMessageMetadata extends ChatMetadata {
  final String errorMessage;
  ErrorMessageMetadata(this.errorMessage);
  factory ErrorMessageMetadata.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageMetadataFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ErrorMessageMetadataToJson(this);
}
