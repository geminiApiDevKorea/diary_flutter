import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/chats/chats_feedback_notifier.dart';
import 'package:diary_flutter/presentation/journal/journal_music_card.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:palestine_console/palestine_console.dart';

class ChatFeedbackWidget extends ConsumerWidget {
  final dynamic state;
  final Journal? myJournal;

  const ChatFeedbackWidget({
    super.key,
    required this.state,
    required this.myJournal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state is ChatsFeedbackData) {
      return _buildRecommendationContent(context, ref);
    } else if (state is ChatsFeedbackError) {
      return _handleErrorState(context, ref, state);
    } else {
      return _buildExistingJournalContent(
        context,
        ref,
      );
    }
  }

  Widget _buildRecommendationContent(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 120),
        const Divider(),
        const SizedBox(height: 13),
        Text('Muse Recommends you',
            style: textStyle.button.withColor(colors.grayScale70)),
        const SizedBox(height: 10),
        Text(myJournal?.song?.reason ?? '',
            style: textStyle.h5.withHeight(1.3)),
        const SizedBox(height: 36),
        Center(
          child: JournalMusicCard(
            song: myJournal?.song?.title ?? '',
            singer: myJournal?.song?.singer ?? '',
            imgUrl: myJournal?.music?.thumbnailUrl ?? '',
            onButtonPressed: () =>
                launchMusicUrl(context, myJournal?.music?.url),
          ),
        ),
        const SizedBox(height: 36),
      ],
    );
  }

  Widget _handleErrorState(
    BuildContext context,
    WidgetRef ref,
    ChatsFeedbackError state,
  ) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    switch (state.statusCode) {
      case 401:
        Print.red("다시 로그인해주세요");
        return const JournalMusicCard(imgUrl: null, onButtonPressed: null);
      case 400:
        Print.red("일기 내용이 없습니다");
        return const SizedBox.shrink();
      case 500:
        Print.red(state.error);
        return const SizedBox.shrink();
      default:
        return Text('Error: ${state.error}',
            style: textStyle.h4.copyWith(color: colors.error));
    }
  }

  Widget _buildExistingJournalContent(BuildContext context, WidgetRef ref) {
    final colors = ref.gemColors;
    final textStyle = ref.gemTextStyle;
    if (myJournal?.music == null) {
      return const SizedBox();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 120),
          const Divider(),
          const SizedBox(height: 13),
          Text('Muse Recommends you',
              style: textStyle.button.withColor(colors.grayScale70)),
          const SizedBox(height: 10),
          Text(myJournal?.song?.reason ?? '',
              style: textStyle.h5.withHeight(1.3)),
          const SizedBox(height: 36),
          Center(
            child: JournalMusicCard(
              song: myJournal?.song?.title,
              singer: myJournal?.song?.singer,
              imgUrl: myJournal?.music?.thumbnailUrl ?? '',
              onButtonPressed: () =>
                  launchMusicUrl(context, myJournal?.music?.url),
            ),
          ),
          const SizedBox(height: 36),
        ],
      );
    }
  }
}

class ChatFeedbackLoadingWidget extends StatelessWidget {
  const ChatFeedbackLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const JournalMusicCard(
      imgUrl: null,
      onButtonPressed: null,
    );
  }
}

// URL 실행을 위한 유틸리티 함수
Future<void> launchMusicUrl(BuildContext context, String? url) async {
  Print.green('Attempting to launch URL: ${url ?? 'default'}');
  if (url != null && url.isNotEmpty) {
    try {
      final uri = Uri.parse(url);

      final laucher =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!laucher) {
        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      }
    } catch (e) {
      Print.red('Error launching URL: $e');
      // showErrorSnackBar(context, 'An error occurred while opening the link');
    }
  } else {
    Print.yellow('No URL available');
    // showErrorSnackBar(context, 'No music link available');
  }
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
