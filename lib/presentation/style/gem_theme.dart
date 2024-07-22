import 'package:diary_flutter/presentation/style/gem_colors.dart';

class GemTheme {
  final GemColors colors;

  const GemTheme({required this.colors});

  factory GemTheme.light() {
    return GemTheme(colors: GemColors.light());
  }

  factory GemTheme.dark() {
    return GemTheme(colors: GemColors.dark());
  }

  GemTheme copyWith({GemColors? colors}) {
    return GemTheme(
      colors: colors ?? this.colors,
    );
  }
}
