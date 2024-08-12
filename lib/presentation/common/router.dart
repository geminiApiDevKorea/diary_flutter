import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/presentation/calendar/calendar_screen.dart';
import 'package:diary_flutter/presentation/journal/journal_completion_screen.dart';
import 'package:diary_flutter/presentation/journal/journal_screen.dart';
import 'package:diary_flutter/presentation/main/main_screen.dart';
import 'package:diary_flutter/presentation/common/custom_transitions.dart';
import 'package:diary_flutter/presentation/my_info/my_info_screen.dart';
import 'package:diary_flutter/presentation/onbording/onbording_screen.dart';
import 'package:diary_flutter/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:diary_flutter/presentation/settings/setting_screen.dart';
import 'package:diary_flutter/presentation/welcome/welcome_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

enum QueryParameterKeys {
  feedbackType,
  previous,
}

/// `QueryParameterKeys` 열거형에 대한 확장(extension) 메서드입니다.
/// 각 열거형 값을 문자열로 변환하여 사용할 수 있도록 합니다.
extension QueryParameterKeysExtension on QueryParameterKeys {
  /// `value` 게터(getter) 메서드는 열거형 값을 문자열로 변환하여 반환합니다.
  /// 열거형 값의 문자열 표현에서 열거형 이름 앞의 'QueryParameterKeys.' 부분을 제거합니다.
  String get value => toString().split('.').last;
  // 예를 들어, QueryParameterKeys.feedbackType의 경우 'feedbackType'이라는 문자열을 반환합니다.
}

FeedbackType parseFeedbackType(GoRouterState state) {
  final feedbackTypeString =
      state.uri.queryParameters[QueryParameterKeys.feedbackType.value];
  if (feedbackTypeString == null) {
    throw Exception('feedback type is not exist');
  }
  return FeedbackType.values.firstWhere(
    (e) => e.toString().split('.').last == feedbackTypeString,
  );
}

enum PreviousScreens {
  calendar,
  main,
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
        builder: (context, state) => const CalendarScreen(),
      ),
      GoRoute(
        path: MyInfoScreen.path,
        name: MyInfoScreen.name,
        builder: (context, state) => const MyInfoScreen(),
      ),
      GoRoute(
        path: OnboardingScreen.path,
        builder: (context, state) => const OnboardingScreen(),
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
                from: SlideDirection.right);
          }),
      GoRoute(
          path: JournalScreen.path,
          name: JournalScreen.name,
          pageBuilder: (context, state) {
            final feedbackType = parseFeedbackType(state);
            const key = ValueKey('journal');
            return CustomTransitions.buildSlideTransitionPage(
              child: JournalScreen(
                feedbackType: feedbackType,
              ),
              key: key,
              from: SlideDirection.right,
              transitionDuration: TransitionDuration.short.value,
            );
          },
          routes: [
            GoRoute(
              path: JournalCompletionScreen.path,
              name: JournalCompletionScreen.name,
              pageBuilder: (context, state) {
                final feedbackType = parseFeedbackType(state);
                const key = ValueKey('journalCompletion');
                return CustomTransitions.buildSlideTransitionPage(
                  child: JournalCompletionScreen(
                    feedbackType: feedbackType,
                  ),
                  key: key,
                  from: SlideDirection.right,
                  transitionDuration: TransitionDuration.short.value,
                );
              },
            ),
          ]),
    ],
  );
}
