import 'package:diary_flutter/domain/provider/onboarding/agreement_notifier.dart';
import 'package:diary_flutter/presentation/onbording/agreement_agree_button.dart';
import 'package:diary_flutter/presentation/onbording/agreement_check_box.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgreementModalBottomSheet extends ConsumerWidget {
  const AgreementModalBottomSheet({super.key});

  createAgreementCheckBox({
    required AgreementType type,
    required AgreementState state,
    required Function(AgreementType) onTap,
  }) {
    return AgreementCheckBox(
      title: type.title,
      isChecked: state.isChecked(type),
      onTap: () => onTap(type),
      isRequired: type.isRequired,
      url: type.url,
    );
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
                    isChecked: agreementState.isAllAgreed,
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
            AgreementAgreeButton(
              bottomPadding: viewPadding.bottom,
              isAllRequiredAgreed: agreementState.isAllRequiredAgreed,
            ),
          ],
        ),
      ),
    );
  }
}
