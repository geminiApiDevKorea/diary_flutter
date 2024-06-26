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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) {
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
