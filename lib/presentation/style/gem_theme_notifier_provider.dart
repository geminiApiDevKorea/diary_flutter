import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/data/storage/persistance_storage.dart';
import 'package:diary_flutter/presentation/style/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'gem_theme.dart';

part 'gem_theme_notifier_provider.g.dart';

@riverpod
class GemThemeNotifier extends _$GemThemeNotifier {
  @override
  GemTheme build() {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    final gemThemeMode = _getGemThemeModeFromStorage(persistanceStorage);
    return gemThemeMode.theme;
  }

  void setTheme(GemThemeMode mode) {
    state = mode.theme;
    _updateThemeStorage(mode);
  }

  void toggleTheme() {
    final newMode =
        state == GemTheme.light() ? GemThemeMode.dark : GemThemeMode.light;
    setTheme(newMode);
  }

  GemThemeMode _getGemThemeModeFromStorage(PersistanceStorage storage) {
    final themeString = storage.getValue<String>('gemThemeMode');
    return themeString == GemThemeMode.light.value
        ? GemThemeMode.light
        : GemThemeMode.dark;
  }

  void _updateThemeStorage(GemThemeMode mode) {
    final persistanceStorage = ref.read(persistanceStorageProvider);
    persistanceStorage.setValue('gemThemeMode', mode.value);
  }
}
