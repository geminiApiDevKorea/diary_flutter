import 'package:json_annotation/json_annotation.dart';

part 'evaluated_prompt_content.g.dart';

@JsonSerializable()
class EvaluatedPromptContent {
  final bool canFeedback;
  final String react;

  EvaluatedPromptContent({
    required this.canFeedback,
    required this.react,
  });

  factory EvaluatedPromptContent.fromJson(Map<String, dynamic> json) =>
      _$EvaluatedPromptContentFromJson(json);
  Map<String, dynamic> toJson() => _$EvaluatedPromptContentToJson(this);
}
