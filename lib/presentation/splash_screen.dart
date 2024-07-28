import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/home_screen.dart';
import 'package:diary_flutter/presentation/onbording/onbording_screen.dart';
import 'package:diary_flutter/presentation/onbording/onbording_title.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends HookConsumerWidget {
  static const String path = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final authState = ref.watch(authProvider);
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () {
        if (authState.value is NeedSigninState) {
          context.pushReplacement(OnboardingScreen.path);
        } else if (authState.value is SignedInState) {
          context.pushReplacement(HomeScreen.path);
        }
      });
      return () {};
    }, []);

    return Scaffold(
      backgroundColor: colors.background,
      body: const OnbordingTitle(),
    );
  }
}
