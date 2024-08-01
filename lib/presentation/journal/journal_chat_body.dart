import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/presentation/journal/provider/journal_service.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatJournalBody extends ConsumerWidget {
  const ChatJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journalEvent =
        ref.watch(journalServiceProvider(journalType: JournalType.chat));
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          color: colors.grayScale90,
          padding: const EdgeInsets.fromLTRB(16, 57, 16, 0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateHeaderDisplay(),
            ],
          ),
        ));
  }
}
