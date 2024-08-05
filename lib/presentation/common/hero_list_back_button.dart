import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeroListBackButton extends ConsumerWidget {
  final void Function() onBack;
  const HeroListBackButton({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    return Hero(
      tag: 'floating',
      child: SizedBox(
        width: 100,
        height: 36,
        child: ElevatedButton.icon(
          label: Text(
            'List',
            style: textStyle.button.copyWith(color: colors.grayScale0),
          ),
          icon: Icon(CupertinoIcons.back, size: 18, color: colors.grayScale50),
          style: ElevatedButton.styleFrom(
            overlayColor: Colors.transparent,
            foregroundColor: colors.grayScale80,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          onPressed: onBack,
        ),
      ),
    );
  }
}
