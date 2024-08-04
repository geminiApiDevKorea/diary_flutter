import 'package:diary_flutter/presentation/calendar/calendar_screen.dart';
import 'package:diary_flutter/presentation/journal_screen.dart';
import 'package:diary_flutter/presentation/main_screen.dart';
import 'package:diary_flutter/presentation/common/custom_transitions.dart';
import 'package:diary_flutter/presentation/home_screen.dart';
import 'package:diary_flutter/presentation/my_info/my_info_screen.dart';
import 'package:diary_flutter/presentation/onbording/onbording_screen.dart';
import 'package:diary_flutter/presentation/terms_screen.dart';
import 'package:diary_flutter/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:diary_flutter/presentation/settings/setting_screen.dart';
import 'package:diary_flutter/presentation/welcome/welcome_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

enum PreviousScreens {
  main,
  calendar,
}

enum QueryParameterKeys {
  previous,
}

final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();
@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: SplashScreen.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: SplashScreen.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: CalendarScreen.path,
        name: CalendarScreen.name,
        pageBuilder: (context, state) {
          return CustomTransitions.buildSlideTransitionPage(
            child: const CalendarScreen(),
            key: state.pageKey,
            from: SlideDirection.left,
          );
        },
      ),
      GoRoute(
        path: MyInfoScreen.path,
        name: MyInfoScreen.name,
        builder: (context, state) {
          final previousScreenString =
              state.uri.queryParameters[QueryParameterKeys.previous.toString()];
          if (previousScreenString == null) {
            throw ArgumentError('previous screen is required');
          }
          final PreviousScreens previousScreen = PreviousScreens.values
              .firstWhere((e) => e.toString() == previousScreenString);
          return MyInfoScreen(
            previousScreen: previousScreen,
          );
        },
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
      GoRoute(
        path: SettingScreen.path,
        builder: (context, state) => const SettingScreen(),
      ),
      GoRoute(
        path: WelcomeScreen.path,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: MainScreen.path,
        pageBuilder: (context, state) {
          return CustomTransitions.buildSlideTransitionPage(
            child: const MainScreen(),
            key: state.pageKey,
            from: SlideDirection.bottom,
          );
        },
      ),
      GoRoute(
        path: JournalScreen.path,
        name: JournalScreen.name,
        pageBuilder: (context, state) {
          final type = state.uri.queryParameters['type'] ?? 'chat';
          final key = ValueKey('journal$type');

          return CustomTransitions.buildSlideTransitionPage(
            child: JournalScreen(type: type),
            key: key,
            from: SlideDirection.right,
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
      ),
    ],
  );
}
