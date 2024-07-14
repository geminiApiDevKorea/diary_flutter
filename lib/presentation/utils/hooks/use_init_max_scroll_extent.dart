import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useInitMaxScrollExtent({
  required ScrollController scrollController,
}) {
  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    return null;
  }, []);
}
