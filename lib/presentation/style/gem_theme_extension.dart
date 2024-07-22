import 'package:diary_flutter/presentation/style/gem_colors.dart';
import 'package:diary_flutter/presentation/style/gem_theme_inherited.dart';
import 'package:flutter/material.dart';
import 'gem_theme.dart';

extension GemThemeExtension on BuildContext {
  GemTheme get gemTheme => GemThemeInherited.of(this).theme;
  GemColors get gemColors => gemTheme.colors;
}
