import 'package:diary_flutter/domain/provider/onboarding/onbording_notifier.dart';
import 'package:diary_flutter/presentation/common/horizontal_swipe_detector.dart';
import 'package:diary_flutter/presentation/onbording/google_login_button.dart';
import 'package:diary_flutter/presentation/onbording/onboarding_animated_text.dart';
import 'package:diary_flutter/presentation/onbording/onbording_dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingContents extends HookConsumerWidget {
  const OnboardingContents({
    super.key,
  });

  _onBoardingAnimate(
    WidgetRef ref,
    AnimationController textAnimationController,
    OnboardingContentState onboardingState,
  ) {
    if (textAnimationController.status == AnimationStatus.completed) {
      if (onboardingState.isLast) {
        ref.read(onboardingNotifierProvider.notifier).finished();
      }
    }
  }

  _onSwipe(HorizontalSwipeDirection direction, WidgetRef ref) {
    final onboardingNotifier = ref.read(onboardingNotifierProvider.notifier);
    if (direction == HorizontalSwipeDirection.leftToRight) {
      onboardingNotifier.previous();
    } else if (direction == HorizontalSwipeDirection.rightToleft) {
      onboardingNotifier.next();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingNotifierProvider);
    final textAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );
    useEffect(() {
      if (onboardingState is OnboardingContentState) {
        onAnimated() => _onBoardingAnimate(
              ref,
              textAnimationController,
              onboardingState,
            );
        textAnimationController.addListener(onAnimated);
        textAnimationController.forward(from: 0.0);
        return () {
          textAnimationController.removeListener(onAnimated);
        };
      } else {
        return null;
      }
    }, [onboardingState]);

    return HorizontalSwipeDetector(
      onSwipe: (direction) => _onSwipe(direction, ref),
      builder: (context) {
        return Container(
          color: Colors.transparent,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 66.0,
                bottom: 25.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  OnbordingDotIndicator(
                    currentIndex: onboardingState.index,
                    indicatorCount: onboardingState.contentLength,
                  ),
                  const SizedBox(height: 16.0),
                  OnboardingAnimatedText(
                    animationController: textAnimationController,
                    content: onboardingState.content,
                  ),
                  const Spacer(),
                  // const GoogleLoginButton(), // TODO: 로그인 테스트 편의를 위해 버튼 추가
                  if (onboardingState.isLast) const GoogleLoginButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
