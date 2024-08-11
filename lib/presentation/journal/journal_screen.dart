import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/presentation/journal/journal_chat_body.dart';
import 'package:diary_flutter/presentation/journal/journal_appbar.dart';
import 'package:diary_flutter/presentation/journal/journal_post_body.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JournalScreen extends HookConsumerWidget {
  const JournalScreen({super.key, required this.feedbackType});
  final FeedbackType feedbackType;

  static const String path = '/journal';
  static const String name = 'journal';

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
                  JournalAppbar(context: context, feedbackType: feedbackType),
              body: JournalBody.create(feedbackType)),
        ),
      ),
    );
  }
}

abstract class JournalBody extends HookConsumerWidget {
  const JournalBody({super.key});

  factory JournalBody.create(FeedbackType type) {
    switch (type) {
      case FeedbackType.chat:
        return const ChatJournalBody();
      case FeedbackType.post:
        return const PostJournalBody();
      default:
        throw ArgumentError('Invalid journal type: $type');
    }
  }
}
