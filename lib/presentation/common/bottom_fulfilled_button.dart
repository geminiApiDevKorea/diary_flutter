import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomFulfilledButton extends ConsumerWidget {
  final String title;
  final bool isEnabled;
  final Function(bool isEnabled) onTap;

  const BottomFulfilledButton({
    super.key,
    required this.title,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    final viewPadding = MediaQuery.of(context).viewPadding;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 50 + viewPadding.bottom,
        child: Material(
          color: isEnabled ? colors.primary50 : colors.grayScale70,
          child: InkWell(
            onTap: () {
              onTap(isEnabled);
            },
            child: Container(
              padding: const EdgeInsets.only(top: 14),
              height: 24,
              width: double.infinity,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: textStyle.h4.withColor(
                    isEnabled ? colors.background : colors.grayScale60,
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
