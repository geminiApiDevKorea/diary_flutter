import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/presentation/journal/provider/journal_service.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostJournalBody extends HookConsumerWidget {
  const PostJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journalEvent =
        ref.watch(journalServiceProvider(journalType: JournalType.post));
    // final journalEventNotifer = ref.read(journalServiceProvider(
    //         date: DateTime.now(), journalType: JournalType.post)
    //     .notifier);

    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final textController = useTextEditingController();
    // useEffect(() {
    //   if (journalEvent is AsyncData) {
    //     final state = journalEvent.value;
    //     if (state is JournalLoaded && state.journal != null) {
    //       textController.text = state.journal!.userInput ?? '';
    //     }
    //   }
    //   return null;
    // }, [journalEvent]);
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          color: colors.grayScale90,
          padding: const EdgeInsets.fromLTRB(16, 57, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateTime.now().toMonthDayOrdinal(),
                style: textStyle.h1.withColor(colors.grayScale0),
              ),
              const SizedBox(height: 12),
              Text(
                'From   ${DateTime.now().toDDMYYHH()}' '   Post',
                style: textStyle.paragraph.withColor(colors.grayScale60),
              ),
              const SizedBox(height: 10),
              Divider(
                color: colors.grayScale80,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              journalEvent.when(
                data: (state) {
                  if (state is JournalLoaded && state.journal != null) {
                    textController.text = state.journal!.userInput ?? '';
                  } else {
                    textController.text = '';
                  }
                  return TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintStyle: textStyle.h2.withColor(colors.placeholder),
                      hintText: 'Just write down any word \nabout your day.',
                      border: InputBorder.none,
                    ),
                    style: textStyle.h2.withColor(colors.grayScale0),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      // textController.text = value;
                      // journalEventNotifer.setUserInput(value);
                      FocusScope.of(context).unfocus();
                    },
                    onChanged: (value) {
                      // 여기에 텍스트 변경 시 수행할 작업을 추가할 수 있습니다.
                      ref
                          .read(journalServiceProvider(
                                  journalType: JournalType.post)
                              .notifier)
                          .setUserInput(value);
                      // journalEventNotifer.setUserInput(value);
                    },
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error: $error'),
              ),
            ],
          ),
        ));
  }
}
