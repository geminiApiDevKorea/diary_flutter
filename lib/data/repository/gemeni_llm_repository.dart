import 'package:diary_flutter/data/repository/llm_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiLLMRepository implements LLMRepository {
  final GenerativeModel model;

  GeminiLLMRepository._({required this.model});

  factory GeminiLLMRepository.create({
    required String modelName,
    required String apiKey,
  }) {
    return GeminiLLMRepository._(
      model: GenerativeModel(
        model: modelName, // 'gemini-1.0-pro'
        apiKey: apiKey,
        generationConfig: GenerationConfig(maxOutputTokens: 100),
      ),
    );
  }

  @override
  Future<LLMResult> sendMessage(String message) async {
    try {
      var response = await model.generateContent([
        Content.text(message),
      ]);
      return LLMResult(
        isSuccess: response.text != null,
        message: response.text ?? '',
      );
    } on GenerativeAIException catch (e) {
      return LLMResult(
        isSuccess: false,
        message: e.message,
      );
    } catch (e) {
      return LLMResult(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
