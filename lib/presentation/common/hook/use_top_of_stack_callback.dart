import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

void useTopOfStackCallback(
  BuildContext context,
  VoidCallback callback, {
  Duration? delay,
}) {
  final router = GoRouter.of(context);
  final currentRoute = router.routerDelegate.currentConfiguration.matches.last;

  final isTop = useState(true);
  final isFirstRun = useState(true);

  useEffect(() {
    void executeCallback() {
      final initialdelay = delay ?? Duration.zero;
      Future.delayed(initialdelay, callback);
      isFirstRun.value = false;
    }

    void listener() {
      final matches = router.routerDelegate.currentConfiguration.matches;
      final newIsTop = matches.isNotEmpty && matches.last == currentRoute;

      if (newIsTop) {
        if (!isTop.value || isFirstRun.value) {
          executeCallback();
        }
      }

      isTop.value = newIsTop;
    }

    // 초기 상태 확인 및 콜백 실행
    listener();

    router.routerDelegate.addListener(listener);
    return () => router.routerDelegate.removeListener(listener);
  }, [callback, delay]);
}
