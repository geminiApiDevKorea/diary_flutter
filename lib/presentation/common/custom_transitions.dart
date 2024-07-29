import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum SlideDirection {
  @JsonValue('right')
  right,
  @JsonValue('left')
  left,
  @JsonValue('top')
  top,
  @JsonValue('bottom')
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
    Duration? transitionDuration,
    Curve? curve,

    /// 슬라이드가 날라오는 시작점
    required SlideDirection from,
  }) {
    return CustomTransitionPage<void>(
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 400),
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: _directionOffsets[from]!,
            end: Offset.zero,
          ).chain(CurveTween(curve: curve ?? Curves.easeInOut)),
        ),
        child: child,
      ),
    );
  }

  static CustomTransitionPage buildFadeTransitionPage({
    required Widget child,
    required LocalKey key,
    Duration? transitionDuration,
    Curve? curve,
  }) {
    return CustomTransitionPage<void>(
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 300),
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation.drive(
          Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: curve ?? Curves.easeInOut)),
        ),
        child: child,
      ),
    );
  }
}
