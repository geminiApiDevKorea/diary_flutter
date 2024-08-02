import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/presentation/journal/date_header_display.dart';
import 'package:diary_flutter/presentation/journal/dialog/delete_confirmation_dialog_mixin.dart';
import 'package:diary_flutter/presentation/journal/journal_music_card.dart';
import 'package:diary_flutter/presentation/journal/provider/journal_service.dart';
import 'package:diary_flutter/presentation/journal/provider/post_text_input.dart';
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
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        color: colors.grayScale90,
        padding: const EdgeInsets.fromLTRB(16, 57, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DateHeaderDisplay(),
            journalEvent.when(
              data: (state) => _JournalContent(state: state),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
          ],
        ),
      ),
    );
  }
}

class _JournalContent extends HookConsumerWidget {
  final JournalState state;

  const _JournalContent({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(
      text: state is JournalLoaded
          ? (state as JournalLoaded).journal?.userInput ?? ''
          : '',
    );
    // final colors = ref.gemColors;
    // final textStyle = ref.gemTextStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _JournalTextField(textController: textController),
        if (state is JournalLoaded) _buildMusicCard(state as JournalLoaded),
      ],
    );
  }

  Widget _buildMusicCard(JournalLoaded loadedState) {
    if (loadedState.journal?.music != null) {
      return JournalMusicCard(
        bottomText: loadedState.journal!.music!.title,
        imgUrl: loadedState.journal!.music!.thumbnailUrl,
        onButtonPressed: () {
          print(loadedState.journal!.music!.url);
        },
      );
    }
    return const SizedBox.shrink();
  }
}

class _JournalTextField extends HookConsumerWidget {
  final TextEditingController textController;

  const _JournalTextField({required this.textController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    final postTextInputNotifier = ref.read(postTextInputProvider.notifier);
    final journalService = ref
        .read(journalServiceProvider(journalType: JournalType.post).notifier);

    final textController =
        useTextEditingController(text: ref.watch(postTextInputProvider));

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final journal = journalService.getJournalForDate(DateTime.now());
        if (journal != null && journal.userInput != null) {
          postTextInputNotifier.setText(journal.userInput!);
          textController.text = journal.userInput!;
        }
      });

      return null;
    }, []);
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
        postTextInputNotifier.setText(value);
      },
    );
  }
}
