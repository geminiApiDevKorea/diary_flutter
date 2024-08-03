import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/presentation/journal/dialog/delete_confirmation_dialog_mixin.dart';
import 'package:diary_flutter/presentation/journal/journal_chat_body.dart';
import 'package:diary_flutter/presentation/journal/journal_floating_action_button.dart';
import 'package:diary_flutter/presentation/journal/journal_post_body.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalScreen extends HookConsumerWidget with DeleteConfirmDialogMixin {
  const JournalScreen({super.key, required this.type});
  final String type;
  static const String path = '/journal';
  static const String name = 'journal';

  JournalType get journalType =>
      type == 'post' ? JournalType.post : JournalType.chat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;

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
            floatingActionButton:
                JournalFloatingActionButton(journalType: journalType),
            body: JournalBody(type: type),
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
