import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  static const String path = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: ref.read(authProvider.notifier).signIn,
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
