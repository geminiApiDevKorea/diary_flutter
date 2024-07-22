import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'gem_theme.dart';

part 'gem_theme_notifier_provider.g.dart';

@riverpod
class GemThemeNotifier extends _$GemThemeNotifier {
  @override
  GemTheme build() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final isDark = persistanceStorage.getValue<bool>('isDark') ?? true;
    return isDark ? GemTheme.dark() : GemTheme.light();
  }

  void setLightTheme() => state = GemTheme.light();

  void setDarkTheme() => state = GemTheme.dark();
}
