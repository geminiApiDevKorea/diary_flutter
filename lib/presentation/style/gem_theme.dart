import 'package:diary_flutter/presentation/style/gem_colors.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';
import 'package:diary_flutter/presentation/style/gem_theme_notifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GemTheme {
  final GemColors colors;
  final GemTextStyle textStyle;

  const GemTheme({required this.colors, required this.textStyle});

  factory GemTheme.of(WidgetRef ref) {
    return ref.watch(gemThemeNotifierProvider);
  }

  factory GemTheme.light() {
    return GemTheme(
      colors: GemColors.light(),
      textStyle: const GemTextStyle(),
    );
  }

  factory GemTheme.dark() {
    return GemTheme(
      colors: GemColors.dark(),
      textStyle: const GemTextStyle(),
    );
  }

  GemTheme copyWith({GemColors? colors, GemTextStyle? textStyle}) {
    return GemTheme(
      colors: colors ?? this.colors,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
