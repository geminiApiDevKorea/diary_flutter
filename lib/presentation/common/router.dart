import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/home_screen.dart';
import 'package:diary_flutter/presentation/onbording/onbording_screen.dart';
import 'package:diary_flutter/presentation/terms_screen.dart';
import 'package:diary_flutter/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: ref.watch(authProvider).when(
          data: (state) => switch (state) {
            SignedInState signedInState =>
              signedInState.isAgreed ? HomeScreen.path : TermsScreen.path,
            _ => OnboardingScreen.path,
          },
          loading: () => OnboardingScreen.path,
          error: (error, _) => OnboardingScreen.path,
        ),
    routes: [
      GoRoute(
        path: SplashScreen.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: OnboardingScreen.path,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: SplashScreen.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: TermsScreen.path,
        builder: (context, state) => const TermsScreen(),
      )
    ],
  );
}
