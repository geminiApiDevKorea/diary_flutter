import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

bool useIsTopOfStack(BuildContext context) {
  final router = GoRouter.of(context);
  final currentRoute = router.routerDelegate.currentConfiguration.matches.last;

  final isTop = useState(true);

  useEffect(() {
    void listener() {
      final matches = router.routerDelegate.currentConfiguration.matches;
      isTop.value = matches.isNotEmpty && matches.last == currentRoute;
    }

    router.routerDelegate.addListener(listener);
    return () => router.routerDelegate.removeListener(listener);
  }, []);

  return isTop.value;
}
