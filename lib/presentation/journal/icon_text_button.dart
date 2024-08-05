import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IconTextButton extends ConsumerWidget {
  final String text;
  final VoidCallback onPressed;

  const IconTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.gemTextStyle;
    final colors = ref.gemColors;

    return SizedBox(
      width: 100,
      height: 36,
      child: ElevatedButton.icon(
        label: Text(
          text,
          style: textStyle.button.copyWith(color: colors.grayScale0),
        ),
        icon: Icon(CupertinoIcons.back, size: 18, color: colors.grayScale50),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.subButtonBackground,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
