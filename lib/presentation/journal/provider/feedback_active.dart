import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feedback_active.g.dart';

@riverpod
class FeedbackActive extends _$FeedbackActive {
  static const key = 'feedback_active';
  @override
  bool build() {
    final persistenceStorage = ref.watch(persistanceStorageProvider);
    final value = persistenceStorage.getValue<bool>(key);
    return value ?? true; // null이면 true 반환
  }

  void toggle() {
    final persistenceStorage = ref.read(persistanceStorageProvider);
    state = !state;
    persistenceStorage.setValue(key, state);
  }
}
