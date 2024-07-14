import 'dart:convert';

import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/data/model/chat_metadata.dart';
import 'package:diary_flutter/data/model/feedback_evaluate_result.dart';
import 'package:diary_flutter/data/provider/gemini_repository_provider.dart';
import 'package:diary_flutter/domain/provider/chats/stored_chats.dart';
import 'package:diary_flutter/domain/provider/chats/stored_feedback_target_chats.dart';
import 'package:diary_flutter/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'evaluate_feedback.g.dart';

sealed class EvaluateFeedBackState {}

class EmptyEvaluateFeedbackState extends EvaluateFeedBackState {
  EmptyEvaluateFeedbackState();
}

class LoadingFeedbackState extends EvaluateFeedBackState {
  LoadingFeedbackState();
}

class GeneratedFeedbackState extends EvaluateFeedBackState {
  final FeedbackEvaluateResult result;
  GeneratedFeedbackState(this.result);
}

@Riverpod(keepAlive: true)
class EvaluateFeedback extends _$EvaluateFeedback {
  @override
  EvaluateFeedBackState build() {
    final storedFeedbackTargetChats =
        ref.read(storedFeedbackTargetChatsProvider);
    if (storedFeedbackTargetChats.isEmpty) {
      return EmptyEvaluateFeedbackState();
    } else {
      return LoadingFeedbackState();
    }
  }

  void generate(List<String> userChatMessages) async {
    state = LoadingFeedbackState();

    const systemPrompt = '''
You are the world's best psychotherapist, renowned for your ability to heal through music.
Analyze emotions based on user's diary.
Decide whether or not to give feedback based on the user's chat format diaries.
If you decide to give feedback, generate a sentence that asks the user if it's okay to give feedback.

Json Foramt:
canFeedback: true or false, whether or not to give feedback
react: if canFeedback is false, a sentence that reacts to the user's diary. if canFeedback is true, a sentence that asks the user if it's okay to give feedback

Example1:
안녕

{
  "canFeedback": false,
  "react": "잘 지냈어요?"
}

Example2:
오늘 잘 지냈어?
나는 힘들었어.
오랫동안 준비해온 시험에서 떨어졌거든

{
  "canFeedback": true,
  "react": "오랫동안 준비해온 시험에서 떨어지는건 정말 힘든 일이에요. 이에 대해 조언을 드리고 싶은데 괜찮을까요?"
}

User's Diaries:
''';

    final geminiRepository = ref.read(
      geminiRepositoryProvider(
        model: GeminiModels.flash,
        apiKey: Env.geminiApiKey,
        systemPrompt: systemPrompt,
        responseMimeType: GeminiResponseMimeTypes.json,
      ),
    );
    final response =
        await geminiRepository.request(userChatMessages.join('\n'));
    final feedbackEvaluateResult = FeedbackEvaluateResult.fromJson(
      jsonDecode(response.message),
    );
    ref.read(storedChatsProvider.notifier).store(Chat(
          role: Role.ai,
          message: feedbackEvaluateResult.react,
          createdAt: DateTime.now(),
          chatMetadata: feedbackEvaluateResult.canFeedback
              ? AskFeedbackMetadata(
                  null,
                  feedbackEvaluateResult.react,
                )
              : null,
        ));
    state = GeneratedFeedbackState(feedbackEvaluateResult);
  }
}
