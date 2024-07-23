import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/data/storage/persistance_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'gem_theme.dart';

part 'gem_theme_notifier_provider.g.dart';

enum GemThemeMode { light, dark }

@riverpod
class GemThemeNotifier extends _$GemThemeNotifier {
  @override
  GemTheme build() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final gemThemeMode = _getGemThemeModeFromStorage(persistanceStorage);
    return _getThemeFromMode(gemThemeMode);
  }

  void setLightTheme() {
    state = GemTheme.light();
    _updateThemeStorage(GemThemeMode.light);
  }

  void setDarkTheme() {
    state = GemTheme.dark();
    _updateThemeStorage(GemThemeMode.dark);
  }

  void toggleTheme() {
    final newMode =
        state == GemTheme.light() ? GemThemeMode.dark : GemThemeMode.light;
    state = _getThemeFromMode(newMode);
    _updateThemeStorage(newMode);
  }

  GemThemeMode _getGemThemeModeFromStorage(PersistanceStorage storage) {
    final themeString = storage.getValue<String>('gemThemeMode');
    return themeString == 'light' ? GemThemeMode.light : GemThemeMode.dark;
  }

  GemTheme _getThemeFromMode(GemThemeMode mode) {
    switch (mode) {
      case GemThemeMode.light:
        return GemTheme.light();
      case GemThemeMode.dark:
        return GemTheme.dark();
    }
  }

  void _updateThemeStorage(GemThemeMode mode) {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    persistanceStorage.setValue(
        'gemThemeMode', mode.toString().split('.').last);
  }
}
