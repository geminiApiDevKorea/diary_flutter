import 'package:diary_flutter/presentation/home_screen.dart';
import 'package:diary_flutter/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:diary_flutter/material_theme_data.dart';

class App extends StatelessWidget with MaterialThemeDataMixin {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Diary',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const SplashScreen(),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
