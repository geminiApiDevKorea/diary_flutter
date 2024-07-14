import 'dart:convert';

import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/data/model/llm_feedback.dart';
import 'package:diary_flutter/data/provider/gemini_repository_provider.dart';
import 'package:diary_flutter/domain/provider/chats/stored_chats.dart';
import 'package:diary_flutter/domain/provider/chats/stored_feedback_target_chats.dart';
import 'package:diary_flutter/env/env.dart';
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
    if (isAccept) {
      const systemPrompt = '''
You are the world's best psychotherapist, renowned for your ability to heal through music.
Analyze emotions based on user's diary.
Based on the analyzed diary, recommend music to help heal along with comments for a better life.

Json Foramt:
comment: Comments that make users' better life
singer: recommended song's singer
title: recommended song's singer
reason: why the song was recommended

Example:
I've been feeling really overwhelmed at work lately. There are so many deadlines, and I'm struggling to keep up. It feels like I'm constantly under pressure and I can't catch a break.

{
  "comment": "It sounds like you're experiencing a significant amount of stress and pressure from your work environment. It's important to take a moment for yourself to relax and unwind. Finding ways to manage this stress is crucial for your well-being.",
  "song": {
    "singer": "Enya",
    "title": "Only Time",
    "reason": "This song has a calming and soothing melody that can help you relax and take a mental break from the stress you're experiencing. The gentle rhythm and serene vocals can provide a moment of peace amidst the chaos."
  }
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
      var storedFeedbackTargetChats =
          ref.read(storedFeedbackTargetChatsProvider);
      final response = await geminiRepository.request(
        storedFeedbackTargetChats.join('\n'),
      );
      final feedback = LLMFeedback.fromJson(
        jsonDecode(response.message),
      );
      ref.read(storedChatsProvider.notifier).store(
            Chat(
              role: Role.ai,
              message: feedback.comment,
              createdAt: DateTime.now(),
            ),
          );
      ref.read(storedChatsProvider.notifier).store(
            Chat(
              role: Role.ai,
              message: '${feedback.song.singer} - ${feedback.song.title}',
              createdAt: DateTime.now(),
            ),
          );
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
