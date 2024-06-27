abstract class PersistanceStorage {
  setValue<T>(String key, T value);
  T? getValue<T>(String key);
  removeValue(String key);
}
