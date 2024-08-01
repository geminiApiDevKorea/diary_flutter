import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension GemThemeExtension on WidgetRef {
  GemTheme get gemTheme => GemTheme.of(this);
  GemColors get gemColors => gemTheme.colors;
  GemTextStyle get gemTextStyle => gemTheme.textStyle;
}
