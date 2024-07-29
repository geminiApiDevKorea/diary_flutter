import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/common/bottom_fulfilled_button.dart';
import 'package:diary_flutter/presentation/main_screen.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WelcomeScreen extends HookConsumerWidget {
  static String get path => '/welcome';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    return Scaffold(
      body: Container(
        color: colors.background,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome!',
                      textAlign: TextAlign.center,
                      style: textStyle.h1.withColor(colors.text),
                    ),
                    const SizedBox(height: 19),
                    Text(
                      'Are you ready to compose\ntoday’s music diary?',
                      textAlign: TextAlign.center,
                      style: textStyle.h2.withColor(colors.text),
                    ),
                  ],
                ),
              ),
              BottomFulfilledButton(
                title: 'I\'m ready!',
                isEnabled: true,
                onTap: (_) => context.pushReplacement(MainScreen.path),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
