import 'package:diary_flutter/data/storage/persistance_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencePersistanceStorage implements PersistanceStorage {
  final SharedPreferences sharedPreferences;
  SharedPreferencePersistanceStorage({required this.sharedPreferences});

  @override
  setValue<T>(String key, T value) => switch (value) {
        (String _) => sharedPreferences.setString(key, value),
        (bool _) => sharedPreferences.setBool(key, value),
        (int _) => sharedPreferences.setInt(key, value),
        (double _) => sharedPreferences.setDouble(key, value),
        (List<String> _) => sharedPreferences.setStringList(key, value),
        _ => throw Exception("지원하지 않는 타입의 값입니다.")
      };

  @override
  T? getValue<T>(String key) {
    final value = sharedPreferences.get(key);
    if (value == null) {
      return null;
    }
    if (T == String) {
      return value as T;
    }
    if (T == int) {
      return value as T;
    }
    if (T == double) {
      return value as T;
    }
    if (T == bool) {
      return value as T;
    }
    if (T == List<String>) {
      return sharedPreferences.getStringList(key) as T;
    }
    throw Exception('$T 타입은 지원하지 않는 타입의 값입니다.');
  }

  @override
  removeValue(String key) {
    sharedPreferences.remove(key);
  }
}
