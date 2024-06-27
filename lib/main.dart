import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/common/types.dart';
import 'package:diary_flutter/presentation/home_screen.dart';
import 'package:diary_flutter/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Diary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[400],
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        HomeScreen.routeName: (context) {
          return HomeScreen(
            homeNavigationNotifier: HomeNavigationNotifier(
              HomeNavigations.home,
            ),
          );
        },
      },
    );
  }
}
