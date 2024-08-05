import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/journal.dart';
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
  final String type;
  const JournalCompletionScreen({super.key, required this.type});

  JournalType get journalType => switch (type) {
        'post' => JournalType.post,
        'chat' => JournalType.chat,
        _ => throw ArgumentError('Invalid journal type: $type'),
      };
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final focusedDate = ref.read(focusedDateProvider);
    final textController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: true, // 필요에 따라 조정
        onPopInvoked: (bool didPop) {
          if (didPop) {
            // 팝 작업이 실제로 수행될 때 실행됩니다.
            FocusScope.of(context).unfocus();
          }
          // 여기에 추가 로직을 넣을 수 있습니다.
        },
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
                            onPressed: () async {
                              // 현재 키보드 가시성 확인
                              final isKeyboardVisible =
                                  MediaQuery.of(context).viewInsets.bottom > 0;

                              // 키보드 숨기기
                              FocusScope.of(context).unfocus();

                              // 키보드가 보이는 상태였다면 잠시 대기
                              if (isKeyboardVisible) {
                                await Future.delayed(
                                    const Duration(milliseconds: 300));
                              }

                              // 컨텍스트가 여전히 유효한지 확인
                              if (!context.mounted) return;

                              context.pop();
                            }),
                      ),
                      const Spacer(),
                      TextButton(
                          child: Text(
                            "Save",
                            style: textStyle.button
                                .copyWith(color: colors.primary50),
                          ),
                          onPressed: () async {
                            // 현재 키보드 가시성 확인
                            final isKeyboardVisible =
                                MediaQuery.of(context).viewInsets.bottom > 0;

                            // 키보드 숨기기
                            FocusScope.of(context).unfocus();

                            // 키보드가 보이는 상태였다면 잠시 대기
                            if (isKeyboardVisible) {
                              await Future.delayed(
                                  const Duration(milliseconds: 300));
                            }

                            // 컨텍스트가 여전히 유효한지 확인
                            if (!context.mounted) return;

                            final colors = ref.gemColors;
                            final journalEventNotifier = ref.read(
                                journalServiceProvider(
                                        journalType: journalType,
                                        focusedDate:
                                            ref.watch(focusedDateProvider))
                                    .notifier);

                            final result = await showConfirmDialog(
                              context: context,
                              colors: colors,
                              title: 'Journal Completed!',
                              leftButtonTitle: 'No',
                              rightButtonTitle: 'Yes',
                              description:
                                  'You cannot write more or modify the content for today.',
                              onClose: () async {
                                if (context.mounted) {
                                  FocusScope.of(context).unfocus();
                                  context.pop();
                                }
                              },
                              onConfirm: () async {
                                final newTitle = textController.text.isEmpty
                                    ? focusedDate.toMonthDayOrdinal()
                                    : textController.text;
                                journalEventNotifier.onSave(
                                    newTitle: newTitle,
                                    journalType: journalType);
                                if (context.mounted) {
                                  FocusScope.of(context).unfocus();
                                  context.pop();
                                  context.pop();
                                }
                              },
                            );
                          }),
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
                          hintText: focusedDate.toMonthDayOrdinal(),
                          hintStyle: textStyle.paragraph
                              .withColor(colors.placeholder)),
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
      ),
    );
  }
}
