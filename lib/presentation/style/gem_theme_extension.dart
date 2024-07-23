import 'package:diary_flutter/presentation/style/gem_theme_inherited.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';

extension GemThemeExtension on BuildContext {
  GemTheme get gemTheme => GemThemeInherited.of(this).theme;
  GemColors get gemColors => gemTheme.colors;
  GemTextStyle get gemTextStyle => gemTheme.textStyle;
}
