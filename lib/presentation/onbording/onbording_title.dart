import 'package:diary_flutter/presentation/style/gem_theme_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnbordingTitle extends ConsumerWidget {
  const OnbordingTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gemTheme = ref.watch(gemThemeNotifierProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 92),
        child: Text(
          'Record\nYour Day',
          style: gemTheme.textStyle.h1,
        ),
      ),
    );
  }
}
