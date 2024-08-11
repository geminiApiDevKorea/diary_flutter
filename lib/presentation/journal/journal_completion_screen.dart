import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/extension/date_time_extension.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/presentation/journal/confirm_dialog.dart';
import 'package:diary_flutter/presentation/journal/provider/feedback_active.dart';
import 'package:diary_flutter/presentation/journal/provider/journal_service.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalCompletionScreen extends HookConsumerWidget {
  static const String path = 'completion';
  static const String name = 'journal_completion';
  final FeedbackType feedbackType;
  const JournalCompletionScreen({super.key, required this.feedbackType});

  // FeedbackType get feedbackType => switch (type) {
  //       'post' => FeedbackType.post,
  //       'chat' => FeedbackType.chat,
  //       _ => throw ArgumentError('Invalid journal type: $type'),
  //     };

  _hideKeyboardIfNeed(BuildContext context) async {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    FocusScope.of(context).unfocus();
    if (isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    if (!context.mounted) return;
  }

  _back(BuildContext context) {
    _hideKeyboardIfNeed(context).then((_) {
      if (!context.mounted) return;
      context.pop();
    });
  }

  _save(
    BuildContext context,
    WidgetRef ref,
    TextEditingController textController,
    DateTime focusedDate,
    FeedbackType feedbackType,
  ) {
    _hideKeyboardIfNeed(context).then((_) async {
      final colors = ref.gemColors;
      final journalEventNotifier = ref.read(journalServiceProvider(
              feedbackType: feedbackType,
              focusedDate: ref.watch(focusedDateProvider))
          .notifier);

      final result = await showConfirmDialog(
        context: context,
        colors: colors,
        title: 'Journal Completed!',
        leftButtonTitle: 'No',
        rightButtonTitle: 'Yes',
        description: 'You cannot write more or modify the content for today.',
        onClose: () {
          FocusScope.of(context).unfocus();
        },
        onConfirm: () async {
          FocusScope.of(context).unfocus();
          final newTitle = textController.text.isEmpty
              ? focusedDate.monthDayOrdinal
              : textController.text;
          await journalEventNotifier.onSave(
              newTitle: newTitle, feedbackType: feedbackType);
        },
      );

      if (result == ConfirmationResult.confirm && context.mounted) {
        FocusScope.of(context).unfocus();
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final focusedDate = ref.read(focusedDateProvider);
    final textController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: colors.grayScale90,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            floatingActionButton: SizedBox(
              height: 52,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'floating',
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: colors.grayScale70,
                        ),
                        onPressed: () async => await _back(context),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      child: Text(
                        "Save",
                        style:
                            textStyle.button.copyWith(color: colors.primary50),
                      ),
                      onPressed: () => _save(context, ref, textController,
                          focusedDate, feedbackType),
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, kToolbarHeight, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text('Title', style: textStyle.paragraph),
                  const SizedBox(height: 10),

                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: colors.grayScale90,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintText: focusedDate.monthDayOrdinal,
                        hintStyle:
                            textStyle.paragraph.withColor(colors.placeholder)),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    thumbColor: WidgetStateProperty.all(colors.primary100),
                    activeColor: colors.primary50,
                    inactiveTrackColor: colors.grayScale50,
                    title: Text("Today's feedback from AI",
                        style: textStyle.paragraph),
                    subtitle: Container(
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(
                          "If activated, you can receive feedback on today.",
                          style: textStyle.caption),
                    ),
                    contentPadding: const EdgeInsets.only(left: 0, right: 0),
                    value: ref.watch(feedbackActiveProvider),
                    onChanged: (bool value) {
                      ref.read(feedbackActiveProvider.notifier).toggle();
                    },
                  ),
                  // SwitchListTile(
                  //   title: const Text('Private'),
                  //   subtitle: const Text('공개하면 친구들이 내 음악 목록을 볼 수 있습니다.'),
                  //   value: false,
                  //   onChanged: (bool value) {
                  //     // Handle change
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
