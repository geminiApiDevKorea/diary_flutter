import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnbordingTitle extends ConsumerWidget {
  const OnbordingTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = GemTheme.of(ref).textStyle;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 92),
        child: Text(
          'Record\nYour Day',
          style: textStyle.h1,
        ),
      ),
    );
  }
}
