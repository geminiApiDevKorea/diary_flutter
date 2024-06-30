import 'package:diary_flutter/data/repository/llm_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRepository implements LLMRepository {
  final GenerativeModel model;

  GeminiRepository({required this.model});

  @override
  Future<GenerativeResult> request(String input) async {
    try {
      var response = await model.generateContent([
        Content.text(input),
      ]);
      return GenerativeResult(
        isSuccess: response.text != null,
        message: response.text ?? '',
      );
    } on GenerativeAIException catch (e) {
      return GenerativeResult(
        isSuccess: false,
        message: e.message,
      );
    } catch (e) {
      return GenerativeResult(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
