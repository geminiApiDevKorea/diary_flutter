import 'package:diary_flutter/presentation/style/gem_theme_inherited.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// extension GemThemeExtension on BuildContext {
//   GemTheme get gemTheme => GemThemeInherited.of(this).theme;
//   GemColors get gemColors => gemTheme.colors;
//   GemTextStyle get gemTextStyle => gemTheme.textStyle;
// }

extension GemThemeExtension on WidgetRef {
  GemTheme get gemTheme => GemTheme.of(this);
  GemColors get gemColors => gemTheme.colors;
  GemTextStyle get gemTextStyle => gemTheme.textStyle;
}
