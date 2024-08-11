import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainHeaderButton extends ConsumerWidget {
  final String text;
  final double? width;
  final VoidCallback onTap;

  const MainHeaderButton({
    super.key,
    this.width,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    return Material(
      color: colors.subButtonBackground,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6.0),
          child: SizedBox(
            height: 31,
            width: width ?? 130,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle.paragraph.copyWith(color: colors.grayScale0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
