import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingAnimatedText extends ConsumerWidget {
  final AnimationController animationController;
  final String content;
  const OnboardingAnimatedText({
    super.key,
    required this.animationController,
    required this.content,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = GemTheme.of(ref).textStyle;
    return AnimatedBuilder(
      animation: animationController,
      child: Text(
        content,
        textAlign: TextAlign.left,
        style: textStyle.h2,
      ),
      builder: (context, child) {
        return Opacity(
          opacity: animationController.value,
          child: Transform.translate(
            offset: Offset(
              0.0 + 10.0 * (1 - animationController.value),
              0.0,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
