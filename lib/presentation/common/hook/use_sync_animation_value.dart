import 'package:diary_flutter/presentation/common/provider/primitive_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

AnimationController useSyncAnimationController({
  required AnimationController controller,
  required WidgetRef ref,
  required String key,
}) {
  useEffect(() {
    void syncControllerToProvider() {
      ref
          .read(doubleNotifierProvider(key: key).notifier)
          .setValue(controller.value);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(syncControllerToProvider);

      // 초기 동기화
      syncControllerToProvider();
    });

    return () {
      controller.removeListener(syncControllerToProvider);
    };
  }, [controller, key]);

  return controller;
}
