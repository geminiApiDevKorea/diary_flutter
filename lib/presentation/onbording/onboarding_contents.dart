import 'package:diary_flutter/presentation/onbording/onbording_dot_indicator.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingContents extends HookConsumerWidget {
  static const List<String> contentTexts = [
    'Capture your daily\nmoments through\na gentle conversation\nwith Gemini.',
    'After recording your day,\na personalized playlist\nis created just for you.',
    'Embrace your emotions\nand reflect on your inner\nself through journaling.',
    'Now, Open your mind\nand face your feelings\nwith music',
  ];
  const OnboardingContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    // useEffect()
    final textStyle = GemTheme.of(ref).textStyle;
    const currentContentIndex = 1;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 66.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnbordingDotIndicator(
              currentIndex: currentContentIndex,
              indicatorCount: contentTexts.length,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: PageView.builder(
                itemCount: contentTexts.length,
                itemBuilder: (context, index) {
                  return Text(
                    contentTexts[index],
                    textAlign: TextAlign.left,
                    style: textStyle.h2,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
