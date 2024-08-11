import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyInfoRowTitle extends ConsumerWidget {
  final String title;
  final bool isPrimary;
  const MyInfoRowTitle({
    super.key,
    required this.title,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = GemTheme.of(ref).textStyle;
    final colors = GemTheme.of(ref).colors;
    return Text(
      title,
      style: isPrimary
          ? textStyle.paragraph.withColor(colors.error)
          : textStyle.paragraph,
    );
  }
}
