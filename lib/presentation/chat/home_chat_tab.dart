import 'package:diary_flutter/presentation/chat/chat_input.dart';
import 'package:diary_flutter/presentation/chat/chat_list.dart';
import 'package:diary_flutter/presentation/common/text_theme_getter_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeChatTab extends ConsumerWidget with TextThemeGetterMixin {
  const HomeChatTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        ChatList(),
        ChatInput(),
      ],
    );
  }
}
