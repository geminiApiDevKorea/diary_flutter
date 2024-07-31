import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/common/bottom_fulfilled_button.dart';
import 'package:diary_flutter/presentation/common/input_field.dart';
import 'package:diary_flutter/presentation/onbording/onbording_dot_indicator.dart';
import 'package:diary_flutter/presentation/settings/setting_app_bar.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:diary_flutter/presentation/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingScreen extends HookConsumerWidget {
  static String get path => '/setting';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    final isValidNickname = useState(false);
    return Scaffold(
      body: Container(
        color: colors.background,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SettingAppBar(),
                    const SizedBox(height: 10),
                    const OnbordingDotIndicator(
                      currentIndex: 0,
                      indicatorCount: 2,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Please enter\nyour nick name',
                      style: textStyle.h2,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'You can change it later.',
                      style: textStyle.paragraph.withColor(colors.caption),
                    ),
                    const SizedBox(height: 16),
                    ref.watch(authProvider).when(
                          data: (authState) {
                            final state = authState;
                            if (state is SignedInState) {
                              isValidNickname.value = state.name.length >= 2;
                              return CustomTextFormField(
                                initialText: state.name,
                                isEditable: false,
                                maxLength: 20,
                                minLength: 2,
                                onChangedInputText: (inputText) {
                                  isValidNickname.value = inputText.length >= 2;
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (error, _) => Text('Error: $error'),
                        ),
                    const Spacer(),
                  ],
                ),
              ),
              BottomFulfilledButton(
                title: 'Next',
                isEnabled: isValidNickname.value,
                onTap: (isEnabled) {
                  if (isEnabled) {
                    context.pushReplacement(WelcomeScreen.path);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
