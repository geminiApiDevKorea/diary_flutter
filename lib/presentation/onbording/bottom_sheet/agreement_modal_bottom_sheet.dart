import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/domain/provider/onboarding/agreement_notifier.dart';
import 'package:diary_flutter/presentation/common/bottom_fulfilled_button.dart';
import 'package:diary_flutter/presentation/common/popup/confirm_popup.dart';
import 'package:diary_flutter/presentation/common/popup/popup_button_param.dart';
import 'package:diary_flutter/presentation/onbording/bottom_sheet/agreement_check_box.dart';
import 'package:diary_flutter/presentation/settings/setting_screen.dart';
import 'package:diary_flutter/presentation/style/gem_colors.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AgreeResult {
  cancel,
  confirm,
}

class AgreementModalBottomSheet extends ConsumerWidget {
  const AgreementModalBottomSheet({super.key});

  Future<AgreeResult?> _showConfirmDialog(
    BuildContext context,
    GemColors colors,
  ) {
    return showDialog<AgreeResult>(
      barrierColor: colors.modalBackground,
      context: context,
      builder: (context) {
        return GemsConfirmPopup(
          title: 'Agree to\nRequired Terms',
          description:
              'After agreeing to the required terms, you can use the app.',
          popupButtonParams: [
            PopupButtonParam(
              title: 'Close',
              isPrimary: false,
              onTap: (popupContext) {
                Navigator.pop(popupContext, AgreeResult.cancel);
              },
            ),
            PopupButtonParam(
              title: 'Confirm',
              isPrimary: true,
              onTap: (popupContext) {
                Navigator.pop(popupContext, AgreeResult.confirm);
              },
            ),
          ],
        );
      },
    );
  }

  createAgreementCheckBox({
    required AgreementType type,
    required AgreementState state,
    required Function(AgreementType) onTap,
  }) {
    return AgreementCheckBox(
      title: type.title,
      isChecked: state.isChecked(type),
      agreementType: type,
      onTap: () => onTap(type),
    );
  }

  _agree({
    required BuildContext context,
    required WidgetRef ref,
    required bool isEnabledAgreement,
  }) {
    requestAgree() {
      ref.read(authProvider.notifier).agree().then(
        (isSuccess) {
          if (isSuccess) {
            context.go(SettingScreen.path);
          }
        },
      );
    }

    if (isEnabledAgreement) {
      requestAgree();
    } else {
      _showConfirmDialog(
        context,
        GemTheme.of(ref).colors,
      ).then(
        (result) {
          if (result == AgreeResult.confirm) {
            requestAgree();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    final viewPadding = MediaQuery.of(context).viewPadding;
    final agreementState = ref.watch(agreementNotifierProvider);
    return SafeArea(
      bottom: false,
      child: Container(
        color: colors.background,
        width: double.infinity,
        height: 429 + viewPadding.bottom,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  Text(
                    'To use this app,\nplease agree to the terms\nand conditions',
                    style: textStyle.h2,
                  ),
                  const SizedBox(height: 18),
                  AgreementCheckBox(
                    title: 'Agree to all',
                    isChecked: agreementState is SelectionAgreementState
                        ? agreementState.isAllAgreed
                        : false,
                    agreementType: null,
                    onTap: () => ref
                        .read(agreementNotifierProvider.notifier)
                        .toggleAllAgreements(),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    height: 1,
                    color: colors.grayScale70,
                  ),
                  const SizedBox(height: 18),
                  createAgreementCheckBox(
                    type: AgreementType.termsOfService,
                    state: agreementState,
                    onTap: (type) => ref
                        .read(agreementNotifierProvider.notifier)
                        .toggleAgreement(type),
                  ),
                  const SizedBox(height: 4),
                  createAgreementCheckBox(
                    type: AgreementType.privacyPolicy,
                    state: agreementState,
                    onTap: (type) => ref
                        .read(agreementNotifierProvider.notifier)
                        .toggleAgreement(type),
                  ),
                  const SizedBox(height: 138),
                ],
              ),
            ),
            BottomFulfilledButton(
              title: 'Agree and Continue',
              isEnabled: agreementState is SelectionAgreementState
                  ? agreementState.isAllRequiredAgreed
                  : true,
              onTap: (isEnabled) => _agree(
                context: context,
                ref: ref,
                isEnabledAgreement: isEnabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
