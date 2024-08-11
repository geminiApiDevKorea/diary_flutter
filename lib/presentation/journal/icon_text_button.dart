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
      width: 109,
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.buttonBackground,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: EdgeInsets.zero, // Remove default padding
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 6), // Add left padding for visual balance
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(CupertinoIcons.back, size: 18, color: colors.grayScale50),
              const SizedBox(width: 14), // Space between icon and text
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: textStyle.button.copyWith(color: colors.text),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
