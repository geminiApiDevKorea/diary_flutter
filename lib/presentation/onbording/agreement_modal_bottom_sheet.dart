import 'package:diary_flutter/presentation/onbording/agreement_agree_button.dart';
import 'package:diary_flutter/presentation/onbording/agreement_check_box.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgreementModalBottomSheet extends ConsumerWidget {
  const AgreementModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    return Container(
      color: colors.background,
      width: double.infinity,
      height: 429,
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
                const AgreementCheckBox(
                  title: 'Agree to all',
                ),
                const SizedBox(height: 18),
                Container(
                  height: 1,
                  color: colors.grayScale70,
                ),
                const SizedBox(height: 18),
                const AgreementCheckBox(
                  title: 'Terms of Service',
                  isRequired: true,
                  url: 'https://example.com',
                ),
                const SizedBox(height: 4),
                const AgreementCheckBox(
                  title: 'Privacy Policy',
                  isRequired: true,
                  url: 'https://example.com',
                ),
                const SizedBox(height: 138),
              ],
            ),
          ),
          const AgreementAgreeButton(),
        ],
      ),
    );
  }
}
