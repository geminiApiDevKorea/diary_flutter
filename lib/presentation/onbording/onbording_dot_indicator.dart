import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnbordingDotIndicator extends ConsumerWidget {
  final int currentIndex;
  final int indicatorCount;
  const OnbordingDotIndicator({
    super.key,
    required this.currentIndex,
    required this.indicatorCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    return SizedBox(
      height: 10,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index == currentIndex ? colors.primary50 : colors.grayScale60,
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 9.0),
        itemCount: indicatorCount,
      ),
    );
  }
}
