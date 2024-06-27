import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/presentation/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Center(
                child: Text('Splash Image'),
              ),
            ),
            Text(
              'Music Diary',
              style: textTheme.headlineLarge,
            ),
            const SizedBox(height: 22),
            Text(
              'Log your vvid emotion with music',
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  HomeScreen.routeName,
                  arguments: HomeNavigations.home,
                ),
                child: Text(
                  'Get started',
                  style: textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
