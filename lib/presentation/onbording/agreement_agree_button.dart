import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgreementAgreeButton extends ConsumerWidget {
  const AgreementAgreeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 50,
        child: Material(
          color: colors.primary50,
          child: InkWell(
            onTap: ref.read(authProvider.notifier).signIn,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: SizedBox(
                height: 24,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Agree and Continue',
                    style: textStyle.h4.withColor(colors.background),
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
