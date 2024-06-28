import 'package:flutter/material.dart';

mixin MaterialThemeDataMixin {
  ThemeData get themeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[400],
      ),
      useMaterial3: true,
    );
  }
}
