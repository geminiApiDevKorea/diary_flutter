import 'package:diary_flutter/domain/provider/chats/chats_prompt_notifier.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssistantChatItem extends ConsumerWidget {
  final String message;

  const AssistantChatItem({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final chatsPrompt = ref.watch(chatsPromptNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          message,
          style:
              textStyle.paragraph.withColor(colors.grayScale60).withHeight(1.2),
        ),
        const SizedBox(height: 10),
        Divider(
          color: colors.grayScale80,
          thickness: 1,
        ),
      ],
    );
  }
}
