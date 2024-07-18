import 'package:diary_flutter/domain/provider/auth/google_sign_in.dart';
import 'package:diary_flutter/presentation/home_screen.dart';
import 'package:diary_flutter/presentation/terms_screen.dart';
import 'package:diary_flutter/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: ref.watch(googleSignInProvider).isSignedIn
        ? HomeScreen.routeName
        : SplashScreen.routeName,
    routes: [
      GoRoute(
        path: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: TermsScreen.routeName,
        builder: (context, state) => const TermsScreen(),
      )
    ],
  );
}
