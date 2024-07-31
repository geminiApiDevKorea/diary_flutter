import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/history.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/presentation/journal/dialog/delete_confirmation_dialog_mixin.dart';
import 'package:diary_flutter/presentation/journal/journal_chat_body.dart';
import 'package:diary_flutter/presentation/journal/journal_post_body.dart';
import 'package:diary_flutter/presentation/journal/provider/journal_service.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

class JournalScreen extends HookConsumerWidget with DeleteConfirmDialogMixin {
  const JournalScreen({super.key, required this.type});
  final String type;
  static const String path = '/journal';
  static const String name = 'journal';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;
    final journalEventNotifer = ref
        .read(journalServiceProvider(journalType: JournalType.post).notifier);
    // ref.read(persistanceStorageProvider).removeValue('journals');
    // final journalEvent = ref.watch(journalServiceProvider(
    //     date: DateTime.now(), journalType: JournalType.post, idToken: '0'));

    return Container(
      color: colors.grayScale90,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
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
                    child: SizedBox(
                      width: 100,
                      height: 36,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          overlayColor: Colors.transparent,
                          foregroundColor: colors.grayScale80,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        onPressed: () async {
                          await journalEventNotifer.setUserInput('dsadfasf');
                          await journalEventNotifer.saveJournal();
                          context.pop();
                        },
                        label: Text(
                          'List',
                          style: textStyle.button
                              .copyWith(color: colors.grayScale0),
                        ),
                        icon: Icon(CupertinoIcons.back,
                            size: 18, color: colors.grayScale50),
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () => {
                            showDeleteConfirmDialog(
                                context: context,
                                colors: colors,
                                onConfirm: () => context.pop())
                          },
                      child: Text(
                        "Delete",
                        style: textStyle.button.copyWith(color: colors.error),
                      )),
                  TextButton(
                      onPressed: () => {},
                      child: Text(
                        "Finish",
                        style:
                            textStyle.button.copyWith(color: colors.primary50),
                      )),
                ],
              ),
            ),
          ),
          body: JournalBody(
            type: type,
          ),
        ),
      ),
    );
  }
}

class JournalBody extends StatelessWidget {
  final String type;

  const JournalBody({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'chat':
        return const ChatJournalBody();
      case 'post':
        return const PostJournalBody();
      default:
        throw ArgumentError('Invalid journal type: $type');
    }
  }
}
