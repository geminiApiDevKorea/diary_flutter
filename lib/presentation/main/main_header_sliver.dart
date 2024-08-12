import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/model/journal.dart';
import 'package:diary_flutter/domain/provider/auth/get_my_name.dart';
import 'package:diary_flutter/domain/provider/common/focused_date.dart';
import 'package:diary_flutter/domain/provider/journal/journal_use_cases.dart';
import 'package:diary_flutter/presentation/common/hook/use_sync_animation_value.dart';
import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/journal/journal_screen.dart';
import 'package:diary_flutter/presentation/main/main_header_button.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainHeaderSliver extends StatelessWidget {
  const MainHeaderSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: MainHeader(),
    );
  }
}

class MainHeader extends HookConsumerWidget {
  const MainHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    final myName = ref.read(getMyNameProvider);
    final myJournalonToday =
        ref.watch(getMyJournalByDateProvider(ref.watch(focusedDateProvider)));
    // final hasFeedback =
    //     ref.watch(getMyJournalByDateProvider(ref.watch(focusedDateProvider)));
    final darkeningAniatmionController = useSyncAnimationController(
        controller: useAnimationController(
            duration: const Duration(milliseconds: 300), initialValue: 0.0),
        ref: ref,
        key: 'darekning');

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: colors.primary100,
        height: 314,
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good Evening, $myName",
                style: textStyle.paragraph.withColor(colors.grayScale60)),
            Text("How was\nyour day?", style: textStyle.h1),
            const SizedBox(height: 50),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: myJournalonToday == null
                  ? _buildCreateJournalButtons(
                      context, ref, darkeningAniatmionController)
                  : _buildViewTodayButton(context, ref, myJournalonToday,
                      darkeningAniatmionController),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateJournalButtons(BuildContext context, WidgetRef ref,
      AnimationController darkeningAnimationController) {
    return Row(
      key: const ValueKey('create_buttons'),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainHeaderButton(
          text: 'Chat to record',
          onTap: () => _navigateToJournal(
              context, ref, FeedbackType.chat, darkeningAnimationController),
        ),
        MainHeaderButton(
          text: 'Add a new record',
          onTap: () => _navigateToJournal(
              context, ref, FeedbackType.post, darkeningAnimationController),
        ),
      ],
    );
  }

  Widget _buildViewTodayButton(
      BuildContext context,
      WidgetRef ref,
      Journal myJournalonToday,
      AnimationController darkeningAnimationController) {
    return Row(
      key: const ValueKey('view_today_button'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MainHeaderButton(
          width: 295,
          text: 'View Today',
          onTap: () => _navigateToJournal(context, ref,
              myJournalonToday.feedbackType, darkeningAnimationController),
        ),
      ],
    );
  }

  void _navigateToJournal(
      BuildContext context,
      WidgetRef ref,
      FeedbackType feedbackType,
      AnimationController darkeningAnimationController) async {
    darkeningAnimationController.forward();

    if (feedbackType == FeedbackType.chat ||
        feedbackType == FeedbackType.post) {
      await ref.read(focusedDateProvider.notifier).resetToToday();
    }

    if (context.mounted) {
      await context.pushNamed(JournalScreen.name, queryParameters: {
        QueryParameterKeys.feedbackType.value: feedbackType.value,
      });
    }

    darkeningAnimationController.reverse();
  }
}
