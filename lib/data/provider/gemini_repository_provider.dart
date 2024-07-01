import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/repository/gemeni_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gemini_repository_provider.g.dart';

@Riverpod(keepAlive: false)
GeminiRepository geminiRepository(
  GeminiRepositoryRef ref, {
  required GeminiModels model,
  required String apiKey,
  required String systemPrompt,
  GeminiResponseMimeTypes responseMimeType = GeminiResponseMimeTypes.text,
}) {
  return GeminiRepository(
    model: GenerativeModel(
      model: model.name,
      apiKey: apiKey,
      systemInstruction: Content.system(systemPrompt),
      generationConfig: GenerationConfig(
        responseMimeType: responseMimeType.parameter,
      ),
    ),
  );
}
