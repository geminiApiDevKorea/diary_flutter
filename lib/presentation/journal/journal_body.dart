import 'package:diary_flutter/presentation/journal/journal_chat_body.dart';
import 'package:diary_flutter/presentation/journal/journal_post_body.dart';
import 'package:flutter/cupertino.dart';

class JournalBody extends StatelessWidget {
  static const String path = '/journal';
  static const String name = 'journal';
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
        return const ChatJournalBody();
    }
  }
}
