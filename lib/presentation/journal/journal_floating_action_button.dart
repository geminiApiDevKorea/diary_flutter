import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/presentation/common/hero_list_back_button.dart';
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
            HeroListBackButton(
              onBack: () => journalEventNotifier.onList().then(
                (value) {
                  context.pop();
                },
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
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  journalEventNotifier.onFinish();
                }),
          ],
        ),
      ),
    );
  }
}
