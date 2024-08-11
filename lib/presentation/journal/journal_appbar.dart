import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/journal/provider/journal_service.dart';
import 'package:diary_flutter/presentation/journal/confirm_dialog.dart';
import 'package:diary_flutter/presentation/journal/icon_text_button.dart';
import 'package:diary_flutter/presentation/journal/journal_completion_screen.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalAppbar extends HookConsumerWidget with JournalAppbarHandlerMixin {
  JournalAppbar({super.key, required this.feedbackType, required this.context});
  final BuildContext context;
  final FeedbackType feedbackType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;
    final focusedDate = ref.read(focusedDateProvider);
    final hasFeedback = ref.watch(hasFeedbackProvider(focusedDate));

    return SizedBox(
      height: 52,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'calendarOrlist',
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IconTextButton(
                  text: 'List',
                  onPressed: () => handleListButton(ref, feedbackType, context),
                ),
              ),
            ),
            const Spacer(),
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      axisAlignment: -1,
                      child: child,
                    ),
                  );
                },
                child: hasFeedback
                    ? TextButton(
                        key: const ValueKey('delete'),
                        child: Text(
                          "Delete",
                          style: textStyle.button.copyWith(color: colors.error),
                        ),
                        onPressed: () =>
                            handleDeleteButton(context, ref, feedbackType),
                      )
                    : Row(
                        key: const ValueKey('delete_and_finish'),
                        children: [
                          TextButton(
                            child: Text(
                              "Delete",
                              style: textStyle.button
                                  .copyWith(color: colors.error),
                            ),
                            onPressed: () =>
                                handleDeleteButton(context, ref, feedbackType),
                          ),
                          TextButton(
                            child: Text(
                              "Finish",
                              style: textStyle.button
                                  .copyWith(color: colors.primary50),
                            ),
                            onPressed: () =>
                                handleFinishButton(context, ref, feedbackType),
                          ),
                        ],
                      ))
          ],
        ),
      ),
    );
  }
}

mixin JournalAppbarHandlerMixin {
  Future<void> handleListButton(
      WidgetRef ref, FeedbackType feedbackType, BuildContext context) async {
    final journalEventNotifier = ref.read(journalServiceProvider(
            feedbackType: feedbackType,
            focusedDate: ref.watch(focusedDateProvider))
        .notifier);
    await journalEventNotifier.onList();
    if (context.mounted) context.pop();
  }

  Future<void> handleDeleteButton(
      BuildContext context, WidgetRef ref, FeedbackType feedbackType) async {
    // // 현재 키보드 가시성 확인
    // final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // // 키보드 숨기기
    // FocusScope.of(context).unfocus();

    // // 키보드가 보이는 상태였다면 잠시 대기
    // if (isKeyboardVisible) {
    //   await Future.delayed(const Duration(milliseconds: 300));
    // }

    // // 컨텍스트가 여전히 유효한지 확인
    // if (!context.mounted) return;

    final colors = ref.gemColors;
    final journalEventNotifier = ref.read(journalServiceProvider(
            feedbackType: feedbackType,
            focusedDate: ref.watch(focusedDateProvider))
        .notifier);

    // ignore: unused_local_variable
    final result = await showConfirmDialog(
      context: context,
      colors: colors,
      title: 'Delete Journal',
      description: 'Once you delete this journal, it cannot be recovered.',
      onClose: () async {
        if (context.mounted) {
          FocusScope.of(context).unfocus();

          // context.pop();
        }
      },
      onConfirm: () async {
        await journalEventNotifier.onDelete();
        if (context.mounted) {
          // context.pop();
          context.pop();
        }
      },
    );
    // if (result == DeleteConfirmationResult.confirm) {
    //   if (context.mounted) {
    //     FocusScope.of(context).unfocus();
    //   }
    // }
  }

  Future<void> handleFinishButton(
      BuildContext context, WidgetRef ref, FeedbackType feedbackType) async {
    // 현재 키보드 가시성 확인
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // 키보드 숨기기
    FocusScope.of(context).unfocus();

    // 키보드가 보이는 상태였다면 잠시 대기
    if (isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 300));
    }

    // 컨텍스트가 여전히 유효한지 확인
    if (!context.mounted) return;

    final journalEventNotifier = ref.read(journalServiceProvider(
            feedbackType: feedbackType,
            focusedDate: ref.read(focusedDateProvider))
        .notifier);
    await journalEventNotifier.onList(); //비어잇으면 빈거라도저장
    if (context.mounted) {
      await context.pushNamed(JournalCompletionScreen.name, queryParameters: {
        QueryParameterKeys.feedbackType.value: feedbackType.value,
      });
    }
    if (context.mounted) {
      FocusScope.of(context).unfocus();
    }
  }
}
