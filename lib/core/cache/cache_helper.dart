abstract interface class CacheHelper {
  /// ! delete the entire cache
  Future<void> clear();

  /// * return a Set of all keys in the cache
  Future<Set<String>> getKeys();

  /// * return a bool indicating if the cache contains the key
  Future<bool> has(String key);

  /// * deletes the key from the cache
  Future<void> remove(String key);

  Future<String> readString(String key);

  /// * read the value of the key from the cache
  Future<String> readStringOr(String key, String fallback);

  /// * read the value of the key from the cache
  Future<String?> readStringOrNull(String key);

  /// * write string to cache
  Future<void> writeString(String key, String value);

  Future<Map<dynamic, dynamic>> readMap(String key);

  /// * read the value of the key from the cache
  Future<Map<dynamic, dynamic>?> readMapOrNull(String key);
  Future<void> writeMap(String key, Map<dynamic, dynamic> value);

  /// * read the value of the key from the cache
  // Future<bool> readBool(String key);
  Future<bool?> readBoolOrNull(String key);
  Future<bool> readBoolOr(String key, bool or);
  Future<void> writeBool(String key, bool value);
}
