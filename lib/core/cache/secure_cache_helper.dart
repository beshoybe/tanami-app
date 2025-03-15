import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tanami_capital/core/cache/cache_helper.dart';

class SecureCacheHelper implements CacheHelper {
  final FlutterSecureStorage db;
  SecureCacheHelper(this.db);

  /// ! delete the entire cache
  @override
  Future<void> clear() => db.deleteAll();

  /// * return a Set of all keys in the cache
  @override
  Future<Set<String>> getKeys() => db.readAll().then<Set<String>>(
        (r) => r.keys.toSet(),
      );

  /// * return a bool indicating if the cache contains the key
  @override
  Future<bool> has(String key) => db.containsKey(key: key);

  /// * deletes the key from the cache
  @override
  Future<void> remove(String key) => db.delete(key: key);

  /// * read the value of the key from the cache
  @override
  Future<String?> readStringOrNull(
    String key,
  ) =>
      db.read(key: key);

  @override
  Future<String> readStringOr(
    String key,
    String fallback,
  ) async =>
      await readStringOrNull(key) ?? fallback;

  @override
  Future<String> readString(String key) async => (await readStringOrNull(key))!;

  @override
  Future<void> writeString(String key, String value) => db.write(
        key: key,
        value: value,
      );

  /// * read the value of the key from the cache
  @override
  Future<bool?> readBoolOrNull(
    String key,
  ) async =>
      bool.tryParse(await readStringOrNull(key) ?? '', caseSensitive: false);

  @override
  Future<bool> readBoolOr(
    String key,
    bool or,
  ) async =>
      await readBoolOrNull(key) ?? or;

  // @override
  // Future<bool> readBool(String key) async => (await readBoolOrNull(key))!;

  @override
  Future<void> writeBool(String key, bool value) => db.write(
        key: key,
        value: value.toString(),
      );

  /// * read the value of the key from the cache
  @override
  Future<Map<dynamic, dynamic>?> readMapOrNull(
    String key,
  ) async {
    final val = await readStringOrNull(key);
    if (val == null || val.isEmpty) return null;
    try {
      final map = jsonDecode(val) as Map?;
      return map;
    } on FormatException {
      return null;
    }
  }

  @override
  Future<Map<dynamic, dynamic>> readMap(String key) async =>
      (await readMapOrNull(key))!;

  @override
  Future<void> writeMap(String key, Map<dynamic, dynamic> value) => db.write(
        key: key,
        value: jsonEncode(value),
      );
}
