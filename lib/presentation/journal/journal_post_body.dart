import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/domain/provider/journal/journal_service.dart';
import 'package:diary_flutter/domain/provider/journal/my_journal_store.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/journal/journal_music_card.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:palestine_console/palestine_console.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostJournalBody extends HookConsumerWidget {
  const PostJournalBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final myJournalStore = ref.watch(myJournalStoreProvider);

    // useState를 사용하여 현재 저널 상태를 관리합니다.
    final currentJournal = useState<Journal?>(null);

    // useEffect를 사용하여 초기값을 설정합니다.
    useEffect(() {
      // 비동기 함수를 정의합니다.
      Future<void> initJournal() async {
        final journal = await ref
            .read(myJournalStoreProvider.notifier)
            .read(DateTime.now());
        currentJournal.value = journal;
      }

      // 초기값을 설정합니다.
      initJournal();

      return null; // cleanup 함수가 필요 없으면 null을 반환합니다.
    }, []); // 빈 배열을 넣어 이 효과가 마운트 시에만 실행되도록 합니다.

    // ref.listen을 사용하여 ChatsFeedbackState의 변경을 감지하고 UI를 업데이트합니다.
    ref.listen<AsyncValue<ChatsFeedbackState>>(
      chatsFeedbackNotifierProvider,
      (previous, next) {
        next.whenData((data) async {
          if (data is ChatsFeedbackData) {
            final journal = await ref
                .read(myJournalStoreProvider.notifier)
                .read(DateTime.now());
            if (journal != null) {
              final updatedJournal = journal.copyWith(
                  music: data.data.music,
                  song: data.data.feedbackResponse.song);
              await ref
                  .read(myJournalStoreProvider.notifier)
                  .createOrUpdate(updatedJournal);
              currentJournal.value = updatedJournal; // UI 상태 업데이트
            }
          }
        });
      },
    );

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        color: colors.grayScale90,
        padding: const EdgeInsets.fromLTRB(16, 57, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DateHeaderDisplay(),
            const _JournalTextField(),
            Visibility(
              visible: currentJournal.value?.music != null,
              child: JournalMusicCard(
                bottomText: currentJournal.value?.music?.title ?? '',
                imgUrl: currentJournal.value?.music?.thumbnailUrl ?? '',
                onButtonPressed: () {
                  print(currentJournal.value?.music?.url ?? '');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _JournalTextField extends HookConsumerWidget {
  const _JournalTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final text = ref.watch(postTextInputProvider);
    final textController = usePostTextInputController(ref);

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
        FocusScope.of(context).unfocus();
      },
      onChanged: (value) {
        Print.white(ref.read(postTextInputProvider) ?? '');
      },
    );
  }
}

// 커스텀 훅 정의
TextEditingController usePostTextInputController(WidgetRef ref) {
  final postTextInputNotifier = ref.read(postTextInputProvider.notifier);
  final controller = useTextEditingController();

  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = DateTime.now();
      final todayJournal = ref.read(getMyJournalByDateProvider(today));
      final initialText = todayJournal?.userInput ?? '';
      controller.text = initialText;
      postTextInputNotifier.setText(initialText);
    });

    void listener() {
      postTextInputNotifier.setText(controller.text);
    }

    controller.addListener(listener);
    return () => controller.removeListener(listener);
  }, [controller]);

  return controller;
}
