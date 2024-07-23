import 'package:diary_flutter/presentation/style/gem_colors.dart';
import 'package:diary_flutter/presentation/style/gem_text_style.dart';

class GemTheme {
  final GemColors colors;
  final GemTextStyle textStyle;

  const GemTheme({required this.colors, required this.textStyle});

  factory GemTheme.light() {
    return GemTheme(
      colors: GemColors.light(),
      textStyle: GemTextStyle(),
    );
  }

  factory GemTheme.dark() {
    return GemTheme(
      colors: GemColors.dark(),
      textStyle: GemTextStyle(),
    );
  }

  GemTheme copyWith({GemColors? colors, GemTextStyle? textStyle}) {
    return GemTheme(
      colors: colors ?? this.colors,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
