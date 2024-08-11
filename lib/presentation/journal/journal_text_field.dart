import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalTextField extends HookConsumerWidget {
  final FeedbackType feedbackType;
  final DateTime date;
  final VoidCallback? onSubmitted;
  final bool submitClear; // 추가된 변수

  const JournalTextField({
    super.key,
    required this.date,
    required this.feedbackType,
    this.onSubmitted,
    this.submitClear = false, // 기본값은 false
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    // ignore: unused_local_variable
    final text = ref.watch(postTextInputProvider);
    final textController = usePostTextInputController(ref, date);
    final focusedDate = ref.read(focusedDateProvider);
    final hasFeedback = ref.watch(hasFeedbackProvider(focusedDate));
    String? getHintText() {
      if (hasFeedback) return null;

      switch (feedbackType) {
        case FeedbackType.post:
          return 'Just write down any word \nabout your day.';
        case FeedbackType.chat:
          return 'Chat to AI';
        default:
          return null;
      }
    }

    return Visibility(
      visible: (!hasFeedback || feedbackType == FeedbackType.post),
      child: TextField(
        autofocus: false,
        controller: textController,
        decoration: InputDecoration(
          hintStyle: textStyle.h2.withColor(colors.placeholder),
          hintText: getHintText(),
          border: InputBorder.none,
        ),
        style: textStyle.h2.withColor(colors.grayScale0),
        maxLines: null,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        enabled: !hasFeedback, // 피드백이 있으면 입력 불가능
        onSubmitted: (value) async {
          FocusScope.of(context).unfocus();
          if (hasFeedback) return; // 피드백이 있으면 제출 로직 실행하지 않음
          onSubmitted?.call();

          /// 순서중요
          if (submitClear) {
            textController.clear();
            // ref.read(postTextInputProvider.notifier).clear();
          }
        },
        onChanged: (value) {
          // Print.white(ref.read(postTextInputProvider) ?? '');
        },
      ),
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
