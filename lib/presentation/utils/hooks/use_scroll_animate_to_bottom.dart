import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useScrollAnimateToBottom<T>({
  required ScrollController scrollController,
  required T scrollTriggerValue,
}) {
  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
    return null;
  }, [scrollTriggerValue]);
}
