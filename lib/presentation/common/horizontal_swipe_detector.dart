import 'package:flutter/material.dart';

enum HorizontalSwipeDirection { rightToleft, leftToRight }

class HorizontalSwipeDetector extends StatelessWidget {
  final WidgetBuilder builder;
  final void Function(HorizontalSwipeDirection direction) onSwipe;
  const HorizontalSwipeDetector({
    super.key,
    required this.builder,
    required this.onSwipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          onSwipe(HorizontalSwipeDirection.leftToRight);
        } else if (details.primaryVelocity! < 0) {
          onSwipe(HorizontalSwipeDirection.rightToleft);
        }
      },
      child: builder(context),
    );
  }
}
