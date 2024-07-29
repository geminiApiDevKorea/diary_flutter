import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/provider/chats_repository_provider.dart';
import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/domain/provider/chats/stored_chats.dart';
import 'package:diary_flutter/domain/provider/chats/stored_feedback_target_chats.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BotChatItem extends ConsumerWidget {
  final Chat chat;
  const BotChatItem({
    required this.chat,
    super.key,
  });

  _onAccept(WidgetRef ref, bool isAccept) async {
    ref.read(storedChatsProvider.notifier).accept(chat, isAccept);
    ref.read(storedFeedbackTargetChatsProvider.notifier).reset();
    // TODO: 인증 정보와 저장된 채팅 히스토리를 가져와 일기에 대한 피드백을 요청합니다.
    // 디자인 적용 과정에서 presentation 레이어에서 domain 레이어로 이동해야 합니다.
    if (isAccept) {
      final state = ref.read(authProvider).value;
      if (state != null && state is SignedInState) {
        try {
          // 유저가 yes를 선택했을 때, 챗봇에게 피드백 요청
          final response =
              await ref.read(chatsRepositoryProvider).postChatsFeedback(
                    bearerToken: 'Bearer ${state.idToken}',
                    type: FeedbackType.chat,
                    body: ChatsRequestBody(
                      userInput: 'yes, please',
                      histories: ref
                          .read(storedChatsProvider)
                          .map(
                            (chat) =>
                                History(role: chat.role, message: chat.message),
                          )
                          .toList(),
                    ),
                  );
          final content = response.content;
          // 응답 결과를 화면에 표시하기 위해 Chat 아이템 추가
          ref.read(storedChatsProvider.notifier).store(
                Chat(
                  role: Role.assistant,
                  message: content.comment,
                  createdAt: DateTime.now(),
                ),
              );
          ref.read(storedChatsProvider.notifier).store(
                Chat(
                  role: Role.assistant,
                  message: '${content.song.singer} - ${content.song.title}',
                  createdAt: DateTime.now(),
                ),
              );
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(
              Icons.smart_toy_outlined,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SelectableText(
                    chat.message,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (chat.isAcceptable) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _onAccept(ref, false),
                        child: const Text('No'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => _onAccept(ref, true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
