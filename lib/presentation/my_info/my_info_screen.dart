import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/my_info/my_info_screen_header.dart';
import 'package:diary_flutter/presentation/style/gem_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyInfoScreen extends ConsumerWidget {
  static const String path = '/$name';
  static const String name = 'my_info';
  final PreviousScreens previousScreen;
  const MyInfoScreen({
    super.key,
    required this.previousScreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  MyInfoScreenHeader(
                    previousScreen: previousScreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}