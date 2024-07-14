import 'package:json_annotation/json_annotation.dart';

part 'feedback_evaluate_result.g.dart';

@JsonSerializable()
class FeedbackEvaluateResult {
  final bool canFeedback;
  final String react;

  FeedbackEvaluateResult(this.canFeedback, this.react);

  factory FeedbackEvaluateResult.fromJson(Map<String, dynamic> json) =>
      _$FeedbackEvaluateResultFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackEvaluateResultToJson(this);
}
