import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';

enum GemThemeMode { light, dark }

extension GemThemeModeExtension on GemThemeMode {
  String get value => switch (this) {
        GemThemeMode.light => 'light',
        GemThemeMode.dark => 'dark',
      };

  GemTheme get theme => switch (this) {
        GemThemeMode.light => GemTheme.light(),
        GemThemeMode.dark => GemTheme.dark(),
      };
}

class GemSpacing {
  /// 수평 간격
  ///
  /// 기본값: 12.0
  static const double horizontalGutter = 12.0;

  /// 수직 간격
  ///
  /// 기본값: 10.0
  static const double verticalGutter = 10.0;

  /// 모든 방향에 동일한 간격 적용
  ///
  /// [horizontalGutter] 값을 사용합니다.
  static EdgeInsets get gutterAll => const EdgeInsets.all(horizontalGutter);

  /// 좌우 방향에만 간격 적용
  ///
  /// [horizontalGutter] 값을 사용합니다.
  static EdgeInsets get gutterHorizontal =>
      const EdgeInsets.symmetric(horizontal: horizontalGutter);

  /// 상하 방향에만 간격 적용
  ///
  /// [verticalGutter] 값을 사용합니다.
  static EdgeInsets get gutterVertical =>
      const EdgeInsets.symmetric(vertical: verticalGutter);
}

class GemRadius {
  /// 큰 반경 (Large)
  ///
  /// 주로 Block 요소에 사용됩니다.
  /// 기본값: 20.0
  static const double large = 20.0;

  /// 중간 반경 (Medium)
  ///
  /// 주로 Input, Button 요소에 사용됩니다.
  /// 기본값: 8.0
  static const double medium = 8.0;

  /// 작은 반경 (Small)
  ///
  /// 주로 작은 Input 요소나 기타 요소에 사용됩니다.
  /// 기본값: 3.0
  static const double small = 3.0;

  /// 큰 반경의 BorderRadius 객체 20px
  ///
  /// [large] 값을 사용합니다.
  static BorderRadius get largeRadius => BorderRadius.circular(large);

  /// 중간 반경의 BorderRadius 객체 8px
  ///
  /// [medium] 값을 사용합니다.
  static BorderRadius get mediumRadius => BorderRadius.circular(medium);

  /// 작은 반경의 BorderRadius 객체 3px
  ///
  /// [small] 값을 사용합니다.
  static BorderRadius get smallRadius => BorderRadius.circular(small);
}
