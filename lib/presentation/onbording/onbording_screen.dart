import 'package:diary_flutter/presentation/onbording/onboarding_contents.dart';
import 'package:diary_flutter/presentation/onbording/onbording_dot_indicator.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerWidget {
  static String get path => '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: const OnboardingContents(),
    );
  }
}
