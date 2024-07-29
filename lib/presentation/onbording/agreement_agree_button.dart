import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgreementAgreeButton extends ConsumerWidget {
  final double bottomPadding;
  final bool isAllRequiredAgreed;
  const AgreementAgreeButton({
    super.key,
    required this.bottomPadding,
    required this.isAllRequiredAgreed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 50 + bottomPadding,
        child: Material(
          color: isAllRequiredAgreed ? colors.primary50 : colors.grayScale70,
          child: InkWell(
            onTap: ref.read(authProvider.notifier).signIn,
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              height: 24,
              width: double.infinity,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Agree and Continue',
                  style: textStyle.h4.withColor(
                    isAllRequiredAgreed
                        ? colors.background
                        : colors.grayScale60,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
