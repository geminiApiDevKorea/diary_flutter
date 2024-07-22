import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';

class GemThemeInherited extends InheritedWidget {
  final GemTheme theme;

  const GemThemeInherited({
    super.key,
    required this.theme,
    required super.child,
  });

  static GemThemeInherited of(BuildContext context) {
    final GemThemeInherited? result =
        context.dependOnInheritedWidgetOfExactType<GemThemeInherited>();
    assert(result != null, 'No GemThemeInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(GemThemeInherited oldWidget) {
    return theme != oldWidget.theme;
  }
}
