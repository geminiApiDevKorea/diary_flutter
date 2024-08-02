import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/data/model/chat_metadata.dart';
import 'package:diary_flutter/data/model/diary/evaluated_prompt_content.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/provider/chats_repository_provider.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/domain/provider/chats/stored_chats.dart';
import 'package:diary_flutter/domain/provider/chats/stored_feedback_target_chats.dart';
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
  final ChatResponse content;
  GeneratedFeedbackState(this.content);
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
    final authState = ref.read(authProvider).value;
    if (authState != null && authState is SignedInState) {
      state = LoadingFeedbackState();
      final response = await ref.read(chatsRepositoryProvider).postChatsPrompt(
            bearerToken: 'Bearer ${authState.idToken}',
            body: ChatsRequestBody(
              userInput: userChatMessages.join('\n'),
              histories: ref
                  .read(storedChatsProvider)
                  .map(
                    (chat) => History(role: chat.role, message: chat.message),
                  )
                  .toList(),
            ),
          );

      final feedbackEvaluateResult = response.chatResponse;
      ref.read(storedChatsProvider.notifier).store(Chat(
            role: Role.assistant,
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
}
