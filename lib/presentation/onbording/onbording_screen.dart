import 'package:diary_flutter/presentation/onbording/onboarding_contents.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerWidget {
  static String get path => '/onboarding';
  const OnboardingScreen({super.key});

  factory OnboardingScreen.from(GoRouterState state) {
    final index = int.tryParse(state.pathParameters['index'] ?? '');
    if (index is int) {
      return const OnboardingScreen();
    } else {
      throw Exception('index path param is not valid');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: const OnboardingContents(),
    );
  }
}
