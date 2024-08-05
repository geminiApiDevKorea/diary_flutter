import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/presentation/journal/journal_chat_body.dart';
import 'package:diary_flutter/presentation/journal/journal_body_appbar.dart';
import 'package:diary_flutter/presentation/journal/journal_post_body.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalScreen extends HookConsumerWidget {
  const JournalScreen({super.key, required this.type});
  final String type;

  static const String path = '/journal';
  static const String name = 'journal';

  JournalType get journalType => switch (type) {
        'post' => JournalType.post,
        'chat' => JournalType.chat,
        _ => throw ArgumentError('Invalid journal type: $type'),
      };

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
                JournalBodyAppBar(context: context, journalType: journalType),
            body: JournalBody(
              type: type,
            ),
          ),
        ),
      ),
    );
  }
}

class JournalBody extends StatelessWidget {
  final String type;

  const JournalBody({
    super.key,
    required this.type,
  });

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
