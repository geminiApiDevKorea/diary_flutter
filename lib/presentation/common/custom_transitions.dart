import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// @JsonEnum()
enum SlideDirection {
  // @JsonValue('right')
  right,
  // @JsonValue('left')
  left,
  // @JsonValue('top')
  top,
  // @JsonValue('bottom')
  bottom
}

class CustomTransitions {
  static final Map<SlideDirection, Offset> _directionOffsets = {
    SlideDirection.right: const Offset(1.0, 0.0),
    SlideDirection.left: const Offset(-1.0, 0.0),
    SlideDirection.top: const Offset(0.0, -1.0),
    SlideDirection.bottom: const Offset(0.0, 1.0),
  };

  static CustomTransitionPage buildSlideTransitionPage({
    required Widget child,
    required LocalKey key,
    required SlideDirection from,
    Duration transitionDuration = const Duration(milliseconds: 400),
    Duration reverseTransitionDuration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<void>(
      transitionDuration: transitionDuration,
      reverseTransitionDuration: transitionDuration,
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: _directionOffsets[from]!,
            end: Offset.zero,
          ).chain(CurveTween(curve: curve)),
        ),
        child: child,
      ),
    );
  }

  static CustomTransitionPage buildFadeTransitionPage({
    required Widget child,
    required LocalKey key,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<void>(
      transitionDuration: transitionDuration,
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation.drive(
          Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: curve)),
        ),
        child: child,
      ),
    );
  }

  // static CustomTransitionPage buildSlideWithDarkeningTransitionPage({
  //   required Widget child,
  //   required LocalKey key,
  //   Duration? transitionDuration,
  //   Curve? curve,
  // }) {
  //   return CustomTransitionPage<void>(
  //     transitionDuration:
  //         transitionDuration ?? const Duration(milliseconds: 300),
  //     key: key,
  //     child: child,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       final slideAnimation = Tween<Offset>(
  //         begin: const Offset(1.0, 0.0),
  //         end: Offset.zero,
  //       ).animate(CurvedAnimation(
  //         parent: animation,
  //         curve: curve ?? Curves.easeInOut,
  //       ));

  //       return Stack(
  //         children: [
  //           // 기존 페이지에 대한 블러와 틴트 효과
  //           AnimatedBuilder(
  //             animation: animation,
  //             builder: (context, _) {
  //               return Animate(
  //                 effects: [
  //                   BlurEffect(
  //                     begin: const Offset(0, 0),
  //                     end: Offset(4 * animation.value, 4 * animation.value),
  //                     duration: 300.ms,
  //                   ),
  //                   TintEffect(
  //                     begin: 0,
  //                     end: animation.value,
  //                     color: Colors.black.withOpacity(0.2),
  //                     duration: 300.ms,
  //                   ),
  //                 ],
  //                 child: Container(color: Colors.transparent),
  //               );
  //             },
  //           ),
  //           // 새 페이지 슬라이드 효과
  //           SlideTransition(
  //             position: slideAnimation,
  //             child: child,
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
