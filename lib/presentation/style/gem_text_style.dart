import 'package:diary_flutter/common/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class GemTextStyle {
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

  /// Serif (Adamina) 48/120%
  final TextStyle h1;

  GemTextStyle({
    TextStyle? h2,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? captionBold,
    TextStyle? paragraph,
    TextStyle? h1,
  })  : h2 = const TextStyle(
            fontFamily: FontFamily.texgyreheros,
            fontSize: 28,
            height: 1.2,
            fontWeight: FontWeight.w400),
        h4 = const TextStyle(
            fontFamily: FontFamily.texgyreheros,
            fontSize: 20,
            height: 1.2,
            fontWeight: FontWeight.w400),
        h5 = const TextStyle(
            fontFamily: FontFamily.texgyreheros,
            fontSize: 18,
            height: 1.2,
            fontWeight: FontWeight.w400),
        captionBold = const TextStyle(
            fontFamily: FontFamily.texgyreheros,
            fontSize: 12,
            height: 1.2,
            fontWeight: FontWeight.bold),
        paragraph = const TextStyle(
            fontFamily: FontFamily.texgyreheros,
            fontSize: 16,
            height: 1.2,
            fontWeight: FontWeight.w400),
        h1 = const TextStyle(
            fontFamily: FontFamily.adamina,
            fontSize: 48,
            height: 1.2,
            fontWeight: FontWeight.w400);

  GemTextStyle copyWith({
    TextStyle? h2,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? captionBold,
    TextStyle? paragraph,
    TextStyle? h1,
  }) {
    return GemTextStyle(
      h2: h2 ?? this.h2,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      captionBold: captionBold ?? this.captionBold,
      paragraph: paragraph ?? this.paragraph,
      h1: h1 ?? this.h1,
    );
  }
}
