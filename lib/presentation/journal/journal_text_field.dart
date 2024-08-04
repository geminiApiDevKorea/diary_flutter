import 'dart:ui';

import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

class JournalTextField extends HookConsumerWidget {
  final DateTime date;
  final VoidCallback? onSubmitted;
  final bool submitClear; // 추가된 변수

  const JournalTextField({
    super.key,
    required this.date,
    this.onSubmitted,
    this.submitClear = false, // 기본값은 false
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final text = ref.watch(postTextInputProvider);
    final textController = usePostTextInputController(ref, date);

    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintStyle: textStyle.h2.withColor(colors.placeholder),
        hintText: 'Just write down any word \nabout your day.',
        border: InputBorder.none,
      ),
      style: textStyle.h2.withColor(colors.grayScale0),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.done,
      onSubmitted: (value) async {
        FocusScope.of(context).unfocus();
        onSubmitted?.call();

        /// 순서중요
        if (submitClear) {
          textController.clear();
          // ref.read(postTextInputProvider.notifier).clear();
        }
      },
      onChanged: (value) {
        Print.white(ref.read(postTextInputProvider) ?? '');
      },
    );
  }
}

// 커스텀 훅 정의
TextEditingController usePostTextInputController(WidgetRef ref, DateTime date) {
  final postTextInputNotifier = ref.read(postTextInputProvider.notifier);
  final controller = useTextEditingController();

  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = date;
      final todayJournal = ref.read(getMyJournalByDateProvider(today));
      final initialText = todayJournal?.userInput ?? '';
      controller.text = initialText;
      postTextInputNotifier.setText(initialText);
    });

    void listener() {
      postTextInputNotifier.setText(controller.text);
    }

    controller.addListener(listener);
    return () => controller.removeListener(listener);
  }, [controller]);

  return controller;
}