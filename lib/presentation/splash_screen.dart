import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/main/main_body.dart';
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

  _moveNext(WidgetRef ref, BuildContext context, String path) {
    Future.delayed(const Duration(seconds: 2), () {
      context.pushReplacement(path);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final authState = ref.watch(authProvider);
    useEffect(() {
      if (authState.value is NeedSigninState) {
        _moveNext(ref, context, OnboardingScreen.path);
      } else if (authState.value is SignedInState) {
        _moveNext(ref, context, MainBody.path);
      }
      return () {};
    }, [authState]);

    return Scaffold(
      backgroundColor: colors.background,
      body: const OnbordingTitle(),
    );
  }
}
