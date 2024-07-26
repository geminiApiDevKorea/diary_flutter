import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/provider/chats_repository_provider.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chats_feedback.g.dart';

// class ChatFeedbackRequest extends _ChatFeedbackRequ

@riverpod
Future<DiaryMusicFeedbackResponse> chatsFeedback(
  ChatsFeedbackRef ref, {
  required List<Chat> chats,
}) {
  final user = ref.read(authProvider).value;
  if (user != null && user is SignedInState) {
    try {
      return ref.read(chatsRepositoryProvider).postChatsFeedback(
            bearerToken: 'Bearer ${user.idToken}',
            body: ChatsFeedbackBody(
              userInput: 'yes, please',
              histories: chats
                  .map(
                    (chat) => History(role: chat.role, message: chat.message),
                  )
                  .toList(),
            ),
          );
    } catch (e) {
      return Future.error(e);
    }
  } else {
    return Future.error('User is not signed in');
  }
}
