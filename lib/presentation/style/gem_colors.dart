import 'package:flutter/material.dart';

sealed class GemColors {
  // 공통 시스템 색상

  /// Error color
  ///
  /// ![](https://placehold.co/15x15/C4273A/C4273A.png) `#C4273A`
  final Color error = const Color(0xFFC4273A);

  /// Warning color
  ///
  /// ![](https://placehold.co/15x15/B19B27/B19B27.png) `#B19B27`
  final Color warning = const Color(0xFFB19B27);

  /// Success color
  ///
  /// ![](https://placehold.co/15x15/0E7A3F/0E7A3F.png) `#0E7A3F`
  final Color success = const Color(0xFF0E7A3F);

  // final Color buttonBackgorund = const Color();
  final Color subButtonBackground = const Color(0xFFF6F5EC);

  final Color buttonBackground = const Color(0xFFF3F3F3);

  // 그레이스케일
  final Color grayScale100;
  final Color grayScale90;
  final Color grayScale80;
  final Color grayScale70;
  final Color grayScale60;
  final Color grayScale50;
  final Color grayScale40;
  final Color grayScale30;
  final Color grayScale20;
  final Color grayScale10;
  final Color grayScale0;

  // 프라이머리 색상
  final Color primary100;
  final Color primary90;
  final Color primary80;
  final Color primary70;
  final Color primary60;
  final Color primary50;
  final Color primary40;
  final Color primary30;
  final Color primary20;
  final Color primary10;
  final Color primary0;

  // UI 관련 색상
  final Color background;
  final Color modalBackground;
  final Color placeholder;
  final Color caption;
  final Color text;

  const GemColors({
    required this.grayScale100,
    required this.grayScale90,
    required this.grayScale80,
    required this.grayScale70,
    required this.grayScale60,
    required this.grayScale50,
    required this.grayScale40,
    required this.grayScale30,
    required this.grayScale20,
    required this.grayScale10,
    required this.grayScale0,
    required this.primary100,
    required this.primary90,
    required this.primary80,
    required this.primary70,
    required this.primary60,
    required this.primary50,
    required this.primary40,
    required this.primary30,
    required this.primary20,
    required this.primary10,
    required this.primary0,
    required this.background,
    required this.modalBackground,
    required this.placeholder,
    required this.caption,
    required this.text,
  });

  factory GemColors.light() = LightGemColors;
  factory GemColors.dark() = DarkGemColors;
}

class LightGemColors extends GemColors {
  const LightGemColors()
      : super(
          grayScale100: const Color(0xFFFFFFFF),
          grayScale90: const Color(0xFFF9F9F9),
          grayScale80: const Color(0xFFEBEBEB),
          grayScale70: const Color(0xFFD0D0D0),
          grayScale60: const Color(0xFFB3B3B3),
          grayScale50: const Color(0xFF898989),
          grayScale40: const Color(0xFF626262),
          grayScale30: const Color(0xFF3C3C3C),
          grayScale20: const Color(0xFF222222),
          grayScale10: const Color(0xFF171717),
          grayScale0: const Color(0xFF000000),
          primary100: const Color(0xFFEBF2EA),
          primary90: const Color(0xFFD3E4DB),
          primary80: const Color(0xFFAACFBB),
          primary70: const Color(0xFF75C89B),
          primary60: const Color(0xFF31975F),
          primary50: const Color(0xFF0D7A4C),
          primary40: const Color(0xFF0F5F3D),
          primary30: const Color(0xFF185139),
          primary20: const Color(0xFF1D4333),
          primary10: const Color(0xFF1B2B24),
          primary0: const Color(0xFF12201A),
          background: const Color(0xFFE3EAE2),
          modalBackground: const Color(0xB3000000),
          placeholder: const Color(0xFFD0D0D0),
          caption: const Color(0xFF898989),
          text: const Color(0xFF000000),
        );
}

class DarkGemColors extends GemColors {
  const DarkGemColors()
      : super(
          grayScale100: const Color(0xFF000000),
          grayScale90: const Color(0xFF171717),
          grayScale80: const Color(0xFF222222),
          grayScale70: const Color(0xFF3C3C3C),
          grayScale60: const Color(0xFF626262),
          grayScale50: const Color(0xFF898989),
          grayScale40: const Color(0xFFB3B3B3),
          grayScale30: const Color(0xFFD0D0D0),
          grayScale20: const Color(0xFFEBEBEB),
          grayScale10: const Color(0xFFF9F9F9),
          grayScale0: const Color(0xFFFFFFFF),
          primary100: const Color(0xFF12201A),
          primary90: const Color(0xFF1B2B24),
          primary80: const Color(0xFF1D4333),
          primary70: const Color(0xFF185139),
          primary60: const Color(0xFF0F5F3D),
          primary50: const Color(0xFF0D7A4C),
          primary40: const Color(0xFF31975F),
          primary30: const Color(0xFF75C89B),
          primary20: const Color(0xFFAACFBB),
          primary10: const Color(0xFFD3E4DB),
          primary0: const Color(0xFFEBF2EA),
          background: const Color(0xFF1C1D1D),
          modalBackground: const Color(0xB3000000),
          placeholder: const Color(0xFF3C3C3C),
          caption: const Color(0xFF898989),
          text: const Color(0xFFFFFFFF),
        );
}
