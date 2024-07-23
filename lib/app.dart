import 'package:diary_flutter/presentation/common/router.dart';
import 'package:diary_flutter/presentation/style/gem_theme_inherited.dart';
import 'package:diary_flutter/presentation/style/gem_theme_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:diary_flutter/material_theme_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget with MaterialThemeDataMixin {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gemTheme = ref.watch(gemThemeNotifierProvider);

    return GemThemeInherited(
      theme: gemTheme,
      child: MaterialApp.router(
        title: 'vinyl diary',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        routerConfig: ref.watch(routerProvider),
      ),
    );
  }
}
