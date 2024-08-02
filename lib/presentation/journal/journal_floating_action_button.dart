import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/presentation/journal/dialog/delete_confirmation_dialog_mixin.dart';
import 'package:diary_flutter/domain/provider/journal/journal_service.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:diary_flutter/domain/provider/journal/stored_journal.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalFloatingActionButton extends HookConsumerWidget
    with DeleteConfirmDialogMixin {
  const JournalFloatingActionButton({super.key, required this.journalType});

  final JournalType journalType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    final journalEvent = ref.watch(journalServiceProvider(
      journalType: journalType,
    ));
    final journalEventNotifier = ref.read(journalServiceProvider(
      journalType: journalType,
    ).notifier);

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
              child: SizedBox(
                width: 100,
                height: 36,
                child: ElevatedButton.icon(
                    label: Text(
                      'List',
                      style:
                          textStyle.button.copyWith(color: colors.grayScale0),
                    ),
                    icon: Icon(CupertinoIcons.back,
                        size: 18, color: colors.grayScale50),
                    style: ElevatedButton.styleFrom(
                      overlayColor: Colors.transparent,
                      foregroundColor: colors.grayScale80,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onPressed: () => journalEventNotifier
                        .onList()
                        .then((value) => context.pop())

                    // journalEventNotifier
                    //     .setJournal(
                    //         userInput: ref.read(postTextInputProvider) ?? '')
                    //     .then((_) => journalEventNotifier
                    //         .saveJournal()
                    //         .then((_) => context.pop())),
                    ),
              ),
            ),
            const Spacer(),
            TextButton(
              child: Text(
                "Delete",
                style: textStyle.button.copyWith(color: colors.error),
              ),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                showDeleteConfirmDialog(
                  context: context,
                  colors: colors,
                  onConfirm: () async {
                    FocusScope.of(context).unfocus();
                    await journalEventNotifier.onDelete();
                    if (context.mounted) {
                      FocusScope.of(context).unfocus();
                      context.pop();
                    }
                  },
                );
              },
            ),
            TextButton(
                child: Text(
                  "Finish",
                  style: textStyle.button.copyWith(color: colors.primary50),
                ),
                onPressed: () => {journalEventNotifier.onFinish()}
                // journalEventNotifier
                //         .setJournal(
                //             userInput: ref.read(postTextInputProvider) ?? '')
                //         .then((_) {
                //       return journalEventNotifier.submitJournal();
                //     }).then((_) {
                //       // print('Journal submitted successfully!');
                //     }).catchError((error) {
                //       // Handle errors if any of the Futures fail
                //       // print('Failed to submit journal: $error');
                //     })
                ),
          ],
        ),
      ),
    );
  }
}
