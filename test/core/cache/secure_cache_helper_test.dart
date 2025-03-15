import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/cache/secure_cache_helper.dart';

import '../../mock_specs.mocks.dart';

void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureCacheHelper cacheHelper;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    cacheHelper = SecureCacheHelper(mockStorage);
  });

  group('SecureCacheHelper Tests', () {
    const testKey = 'testKey';
    const testValue = 'testValue';
    const testMap = {'key': 'value'};
    const testMapString = '{"key":"value"}';

    test('should write string to cache', () async {
      await cacheHelper.writeString(testKey, testValue);
      verify(mockStorage.write(key: testKey, value: testValue)).called(1);
    });

    test('should read string from cache', () async {
      when(mockStorage.read(key: testKey)).thenAnswer((_) async => testValue);
      final result = await cacheHelper.readStringOrNull(testKey);
      expect(result, testValue);
      verify(mockStorage.read(key: testKey)).called(1);
    });

    test('should return fallback when key does not exist', () async {
      when(mockStorage.read(key: testKey)).thenAnswer((_) async => null);
      final result = await cacheHelper.readStringOr(testKey, 'fallback');
      expect(result, 'fallback');
    });

    test('should return true if key exists', () async {
      when(mockStorage.containsKey(key: testKey)).thenAnswer((_) async => true);
      final result = await cacheHelper.has(testKey);
      expect(result, true);
    });

    test('should return false if key does not exist', () async {
      when(
        mockStorage.containsKey(key: testKey),
      ).thenAnswer((_) async => false);
      final result = await cacheHelper.has(testKey);
      expect(result, false);
    });

    test('should remove a key', () async {
      await cacheHelper.remove(testKey);
      verify(mockStorage.delete(key: testKey)).called(1);
    });

    test('should clear all storage', () async {
      await cacheHelper.clear();
      verify(mockStorage.deleteAll()).called(1);
    });

    test('should write and read a bool value', () async {
      await cacheHelper.writeBool(testKey, true);
      verify(mockStorage.write(key: testKey, value: 'true')).called(1);
    });

    test('should read boolean value', () async {
      when(mockStorage.read(key: testKey)).thenAnswer((_) async => 'true');
      final result = await cacheHelper.readBoolOr(testKey, false);
      expect(result, true);
    });

    test('should return fallback boolean when value is null', () async {
      when(mockStorage.read(key: testKey)).thenAnswer((_) async => null);
      final result = await cacheHelper.readBoolOr(testKey, false);
      expect(result, false);
    });

    test('should write and read a map value', () async {
      await cacheHelper.writeMap(testKey, testMap);
      verify(
        mockStorage.write(key: testKey, value: '{"key":"value"}'),
      ).called(1);
    });

    test('should read map value from cache', () async {
      when(
        mockStorage.read(key: testKey),
      ).thenAnswer((_) async => '{"key":"value"}');
      final result = await cacheHelper.readMapOrNull(testKey);
      expect(result, testMap);
    });

    test('should return null for invalid map data', () async {
      when(
        mockStorage.read(key: testKey),
      ).thenAnswer((_) async => 'invalid json');
      final result = await cacheHelper.readMapOrNull(testKey);
      expect(result, null);
    });

    test('should return all keys', () async {
      when(
        mockStorage.readAll(),
      ).thenAnswer((_) async => {'key1': 'value1', 'key2': 'value2'});
      final keys = await cacheHelper.getKeys();
      expect(keys, {'key1', 'key2'});
    });
    test('should read string from cache', () async {
      when(mockStorage.read(key: testKey)).thenAnswer((_) async => testValue);
      final result = await cacheHelper.readString(testKey);
      expect(result, testValue);
      verify(mockStorage.read(key: testKey)).called(1);
    });

    test(
      'should throw error when reading string that does not exist',
      () async {
        when(mockStorage.read(key: testKey)).thenAnswer((_) async => null);
        expect(
          () => cacheHelper.readString(testKey),
          throwsA(isA<TypeError>()),
        );
      },
    );

    test('should read map from cache', () async {
      when(
        mockStorage.read(key: testKey),
      ).thenAnswer((_) async => testMapString);
      final result = await cacheHelper.readMap(testKey);
      expect(result, testMap);
      verify(mockStorage.read(key: testKey)).called(1);
    });

    test('should throw error when reading invalid map', () async {
      when(
        mockStorage.read(key: testKey),
      ).thenAnswer((_) async => 'invalid json');
      expect(() => cacheHelper.readMap(testKey), throwsA(isA<TypeError>()));
    });
  });
}
