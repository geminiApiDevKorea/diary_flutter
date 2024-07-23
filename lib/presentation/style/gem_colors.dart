import 'package:flutter/material.dart';

class GemColors {
  final Color background;
  final Color text;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color error;

  const GemColors({
    required this.background,
    required this.text,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.error,
  });

  factory GemColors.light() {
    return const GemColors(
      background: Color(0xFFF5F5F5),
      text: Color(0xFF333333),
      primary: Color(0xFF2196F3),
      secondary: Color(0xFF4CAF50),
      accent: Color(0xFFFFC107),
      error: Color(0xFFF44336),
    );
  }

  factory GemColors.dark() {
    return const GemColors(
      background: Color(0xFF121212),
      text: Color(0xFFFFFFFF),
      primary: Color(0xFF90CAF9),
      secondary: Color(0xFF81C784),
      accent: Color(0xFFFFD54F),
      error: Color(0xFFE57373),
    );
  }

  GemColors copyWith({
    Color? background,
    Color? text,
    Color? primary,
    Color? secondary,
    Color? accent,
    Color? error,
  }) {
    return GemColors(
      background: background ?? this.background,
      text: text ?? this.text,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      error: error ?? this.error,
    );
  }
}
