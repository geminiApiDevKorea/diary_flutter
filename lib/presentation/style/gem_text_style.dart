import 'package:diary_flutter/common/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class GemTextStyle {
  /// Serif (Adamina) 48/120%
  final TextStyle h1;

  /// Sans (Texgyreheros) 28/120%
  final TextStyle h2;

  /// Sans (Texgyreheros) 20/120%
  final TextStyle h4;

  /// Sans (Texgyreheros) 18/120%
  final TextStyle h5;

  /// Sans (Texgyreheros) 12/120%
  final TextStyle captionBold;

  /// Sans (Texgyreheros) 16/120%
  final TextStyle paragraph;

  /// Sans (Texgyreheros) 14/20%
  final TextStyle button;

  /// Sans (Texgyreheros) 12/120%
  final TextStyle caption;

  const GemTextStyle({
    this.h1 = const TextStyle(
        fontFamily: FontFamily.adamina,
        fontSize: 48,
        height: 1.2,
        fontWeight: FontWeight.w400),
    this.h2 = const TextStyle(
        fontFamily: FontFamily.texgyreheros,
        fontSize: 28,
        height: 1.2,
        fontWeight: FontWeight.w400),
    this.h4 = const TextStyle(
        fontFamily: FontFamily.texgyreheros,
        fontSize: 20,
        height: 1.2,
        fontWeight: FontWeight.w400),
    this.h5 = const TextStyle(
        fontFamily: FontFamily.texgyreheros,
        fontSize: 18,
        height: 1.2,
        fontWeight: FontWeight.w400),
    this.captionBold = const TextStyle(
        fontFamily: FontFamily.texgyreheros,
        fontSize: 12,
        height: 1.2,
        fontWeight: FontWeight.bold),
    this.paragraph = const TextStyle(
        fontFamily: FontFamily.texgyreheros,
        fontSize: 16,
        height: 1.2,
        fontWeight: FontWeight.w400),
    this.button = const TextStyle(
        fontFamily: FontFamily.texgyreheros,
        fontSize: 14,
        height: 0.2,
        fontWeight: FontWeight.w400),
    this.caption = const TextStyle(
        fontFamily: FontFamily.texgyreheros,
        fontSize: 12,
        height: 1.2,
        fontWeight: FontWeight.w400),
  });
}

extension GemTextStyleExtension on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withFontSize(double fontSize) => copyWith(fontSize: fontSize);
  TextStyle withFontWeight(FontWeight fontWeight) =>
      copyWith(fontWeight: fontWeight);
  TextStyle withLetterSpacing(double letterSpacing) =>
      copyWith(letterSpacing: letterSpacing);
  TextStyle withHeight(double height) => copyWith(height: height);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
}
