import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/presentation/journal/provider/journal_service.dart';
import 'package:diary_flutter/presentation/journal/confirm_dialog.dart';
import 'package:diary_flutter/presentation/journal/icon_text_button.dart';
import 'package:diary_flutter/presentation/journal/journal_completion_screen.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalBodyAppBar extends HookConsumerWidget
    with JournalBodyAppbarHandlerMixin {
  const JournalBodyAppBar({super.key, required this.journalType});

  final JournalType journalType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    return SizedBox(
      height: 52,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'floating',
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IconTextButton(
                  text: 'List',
                  onPressed: () => handleListButton(ref, journalType, context),
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              child: Text(
                "Delete",
                style: textStyle.button.copyWith(color: colors.error),
              ),
              onPressed: () => handleDeleteButton(context, ref, journalType),
            ),
            TextButton(
                child: Text(
                  "Finish",
                  style: textStyle.button.copyWith(color: colors.primary50),
                ),
                onPressed: () => handleFinishButton(context, ref, journalType)),
          ],
        ),
      ),
    );
  }
}

mixin JournalBodyAppbarHandlerMixin {
  Future<void> handleListButton(
      WidgetRef ref, JournalType journalType, BuildContext context) async {
    final journalEventNotifier = ref.read(journalServiceProvider(
            journalType: journalType,
            focusedDate: ref.watch(focusedDateProvider))
        .notifier);
    await journalEventNotifier.onList();
    if (context.mounted) context.pop();
  }

  Future<void> handleDeleteButton(
      BuildContext context, WidgetRef ref, JournalType journalType) async {
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

    final colors = ref.gemColors;
    final journalEventNotifier = ref.read(journalServiceProvider(
            journalType: journalType,
            focusedDate: ref.watch(focusedDateProvider))
        .notifier);

    final result = await showConfirmDialog(
      context: context,
      colors: colors,
      title: 'Delete Journal',
      description: 'Once you delete this journal, it cannot be recovered.',
      onConfirm: () async {
        await journalEventNotifier.onDelete();
      },
    );

    if (result == DeleteConfirmationResult.confirm && context.mounted) {
      FocusScope.of(context).unfocus();
      context.pop();
    }
  }

  Future<void> handleFinishButton(
      BuildContext context, WidgetRef ref, JournalType journalType) async {
    FocusScope.of(context).unfocus();
    // final journalEventNotifier =
    //     ref.read(journalServiceProvider(journalType: journalType).notifier);
    // await journalEventNotifier.onFinish();
    context.pushNamed(JournalCompletionScreen.name);
  }
}
