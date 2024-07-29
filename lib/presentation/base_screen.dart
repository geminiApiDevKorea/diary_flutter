import 'dart:ui';

import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/journal/journal_body.dart';
import 'package:diary_flutter/presentation/main/main_body.dart';
import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BaseScreen extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const BaseScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path =
        ref.watch(routerProvider).routerDelegate.currentConfiguration.uri.path;
    final animationKey = useMemoized(() => UniqueKey(), [path]);
    final colors = GemTheme.of(ref).colors;
    print('BaseScreen: $path');

    // 각 경로에 대한 설정을 맵으로 관리
    final pathConfigs = {
      MainBody.path: PathConfig(
          width: 140,
          text: 'Calendar',
          onTap: () => print('Calendar'),
          backgroundColor: colors.primary100),
      JournalBody.path: PathConfig(
          width: 100,
          text: 'List',
          onTap: () => context.goNamed(MainBody.name),
          backgroundColor: colors.grayScale90),
      // 여기에 새로운 경로를 추가할 수 있습니다.
    };

    // 현재 경로에 대한 설정을 가져옵니다. 없으면 기본값 사용
    final currentConfig = pathConfigs[path] ?? PathConfig();
    return Container(
      color: currentConfig.backgroundColor,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          backgroundColor: currentConfig.backgroundColor,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          floatingActionButton: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: currentConfig.width,
                    child: Material(
                      color: context.gemColors.grayScale80,
                      borderRadius: BorderRadius.circular(32),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        onTap: currentConfig.onTap,
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(CupertinoIcons.back,
                                  size: 18,
                                  color: context.gemColors.grayScale50),
                              const SizedBox(width: 8),
                              Flexible(
                                  child: Animate(
                                key: animationKey,
                                effects: [
                                  FadeEffect(
                                      duration: 300.ms,
                                      curve: Curves.easeInOut),
                                ],
                                child: Text(
                                  currentConfig.text,
                                  key: ValueKey<String>(currentConfig.text),
                                  style: context.gemTextStyle.button.copyWith(
                                      color: context.gemColors.grayScale0),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: navigationShell,
        ),
      ),
    );
  }
}

class PathConfig {
  final double width;
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;

  PathConfig({
    this.width = 100,
    this.text = '',
    this.onTap = _defaultOnTap,
    this.backgroundColor = Colors.transparent,
  });

  static void _defaultOnTap() {}
}
