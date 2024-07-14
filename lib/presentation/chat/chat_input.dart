import 'package:diary_flutter/data/model/chat.dart';
import 'package:diary_flutter/domain/provider/chats/stored_chats.dart';
import 'package:diary_flutter/presentation/utils/hooks/use_is_text_editing_controller_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatInput extends HookConsumerWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final isEmpty = useIsTextEditingControllerEmpty(textEditingController);
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(hintText: 'Enter your message'),
              onSubmitted: (value) {
                if (!isEmpty) {
                  ref
                      .read(storedChatsProvider.notifier)
                      .store(Chat.user(textEditingController.text));
                  textEditingController.clear();
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: isEmpty
                ? null
                : () {
                    ref
                        .read(storedChatsProvider.notifier)
                        .store(Chat.user(textEditingController.text));
                    textEditingController.clear();
                  },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
