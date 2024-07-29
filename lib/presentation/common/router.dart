import 'package:diary_flutter/domain/provider/auth/auth.dart';
import 'package:diary_flutter/presentation/base_screen.dart';
import 'package:diary_flutter/presentation/common/custom_transitions.dart';
import 'package:diary_flutter/presentation/home_screen.dart';
import 'package:diary_flutter/presentation/journal/journal_body.dart';
import 'package:diary_flutter/presentation/journal/journal_chat_body.dart';
import 'package:diary_flutter/presentation/journal/journal_post_body.dart';
import 'package:diary_flutter/presentation/main/main_body.dart';
import 'package:diary_flutter/presentation/onbording/onbording_screen.dart';
import 'package:diary_flutter/presentation/terms_screen.dart';
import 'package:diary_flutter/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();
@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: ref.watch(authProvider).when(
          data: (state) => switch (state) {
            SignedInState signedInState =>
              signedInState.isAgreed ? HomeScreen.path : TermsScreen.path,
            _ => SplashScreen.path,
          },
          loading: () => SplashScreen.path,
          error: (error, _) => SplashScreen.path,
        ),
    // initialLocation: MainBody.path,
    debugLogDiagnostics: true,
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
        path: HomeScreen.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: TermsScreen.path,
        builder: (context, state) => const TermsScreen(),
      ),
      StatefulShellRoute.indexedStack(
          pageBuilder: (context, state, navigationShell) {
            return NoTransitionPage(
              child: BaseScreen(navigationShell: navigationShell),
              key: state.pageKey,
            );
          },
          branches: [
            StatefulShellBranch(navigatorKey: mainKey, routes: [
              GoRoute(
                path: MainBody.path,
                name: MainBody.name,
                pageBuilder: (context, state) {
                  const key = ValueKey('main');

                  return const NoTransitionPage(
                    child: MainBody(),
                    key: key,
                  );
                },
              ),
              GoRoute(
                path: JournalBody.path,
                name: JournalBody.name,
                pageBuilder: (context, state) {
                  final type = state.uri.queryParameters['type'] ?? 'chat';
                  final key = ValueKey('journal$type');

                  return CustomTransitions.buildSlideTransitionPage(
                      child: JournalBody(type: type),
                      key: key,
                      from: SlideDirection.right);
                },
              ),
            ]),
          ])
    ],
  );
}
