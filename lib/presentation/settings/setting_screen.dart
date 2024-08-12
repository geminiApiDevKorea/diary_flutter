import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/domain/provider/auth/get_my_id_token.dart';
import 'package:diary_flutter/presentation/common/bottom_fulfilled_button.dart';
import 'package:diary_flutter/presentation/onbording/onbording_dot_indicator.dart';
import 'package:diary_flutter/presentation/settings/setting_app_bar.dart';
import 'package:diary_flutter/presentation/settings/setting_gender.dart';
import 'package:diary_flutter/presentation/settings/setting_name_text_field.dart';
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
    final isEnableNext = useState(false);
    final settingPhase = useState(SettingPhase.name);
    final selectedGender = useState<Gender?>(null);
    final insertedName = useState<String>('');
    final nextAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );
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
                    OnbordingDotIndicator(
                      currentIndex: settingPhase.value.index,
                      indicatorCount: SettingPhase.values.length,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      settingPhase.value.title,
                      style: textStyle.h2,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      settingPhase.value.description,
                      style: textStyle.paragraph.withColor(colors.caption),
                    ),
                    SizedBox(
                        height:
                            settingPhase.value == SettingPhase.name ? 16 : 42),
                    Stack(
                      children: [
                        SettingNameTextField(
                          onChangedName: (name) {
                            insertedName.value = name;
                            isEnableNext.value = name.length >= 2;
                          },
                          animation: nextAnimationController,
                        ),
                        SettingGender(
                          selectedGender: selectedGender.value,
                          onSelect: (gender) {
                            isEnableNext.value = true;
                            selectedGender.value = gender;
                          },
                          animation: nextAnimationController,
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              BottomFulfilledButton(
                title:
                    settingPhase.value.isLastSettingPhase ? 'Submit' : 'Next',
                isEnabled: isEnableNext.value,
                onTap: (isEnabled) {
                  if (isEnabled) {
                    final nextPhase = settingPhase.value.nextPhase;
                    if (nextPhase != null) {
                      isEnableNext.value = false;
                      settingPhase.value = nextPhase;
                      nextAnimationController.forward();
                    } else {
                      final idToken = ref.read(getMyIdTokenProvider);
                      ref
                          .read(authProvider.notifier)
                          .postUser(
                              idToken: idToken,
                              nickname: insertedName.value,
                              gender: selectedGender.value ?? Gender.others)
                          .then(
                            (_) => context.pushReplacement(WelcomeScreen.path),
                          );
                    }
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
