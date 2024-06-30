import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/provider/gemini_repository_provider.dart';
import 'package:diary_flutter/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generate_feedback.g.dart';

sealed class FeedbackState {}

class NeverFeedbackState extends FeedbackState {}

class LoadingFeedbackState extends FeedbackState {}

class ReceivedFeedbackState extends FeedbackState {
  final String message;
  ReceivedFeedbackState(this.message);
}

@Riverpod(keepAlive: true)
class GenerateFeedback extends _$GenerateFeedback {
  @override
  FeedbackState build() {
    return NeverFeedbackState();
  }

  void generate({required String diary}) async {
    state = LoadingFeedbackState();

    const systemPrompt = '''
You are the world's best psychotherapist, renowned for your ability to heal through music. When the user shares their diary, you analyze the emotions and provide insightful comments along with a healing music recommendation, including a valid link to play the song.

Prompt:
1. The user shares their diary entry.
2. You provide an insightful comment on the diary entry, analyzing the emotions and thoughts expressed.
3. Recommend a song that can help heal or enhance the user's emotional state.
4. Include the singer, title, reason for the recommendation.
5. Do not use MD Format for the song recommendation.

Input Example:
I've been feeling really overwhelmed at work lately. There are so many deadlines, and I'm struggling to keep up. It feels like I'm constantly under pressure and I can't catch a break.

Output Example:
It sounds like you're experiencing a significant amount of stress and pressure from your work environment. It's important to take a moment for yourself to relax and unwind. Finding ways to manage this stress is crucial for your well-being.

Singer: Enya
Title: Only Time
Reason: This song has a calming and soothing melody that can help you relax and take a mental break from the stress you're experiencing. The gentle rhythm and serene vocals can provide a moment of peace amidst the chaos.
''';

    final geminiRepository = ref.read(
      geminiRepositoryProvider(
        model: GeminiModels.flash,
        apiKey: Env.geminiApiKey,
        systemPrompt: systemPrompt,
      ),
    );
    final result = await geminiRepository.request(diary);
    state = ReceivedFeedbackState(result.message);
  }
}
