import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/core/cache/secure_cache_helper.dart';

import '../../mock_specs.mocks.dart';

// Generate a mock class
void main() {
  late ProviderContainer container;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();

    // Create a provider container and override the provider with the mock
    container = ProviderContainer(
      overrides: [
        flutterSecureStorageProvider.overrideWithValue(mockSecureStorage),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'flutterSecureStorageProvider should provide a FlutterSecureStorage instance',
    () {
      final storage = container.read(flutterSecureStorageProvider);
      expect(storage, isA<FlutterSecureStorage>());
    },
  );

  test('cacheHelperProvider should provide a SecureCacheHelper instance', () {
    final cacheHelper = container.read(cacheHelperProvider);
    expect(cacheHelper, isA<SecureCacheHelper>());
  });

  test(
    'cacheHelperProvider should write and read values from secure storage',
    () async {
      const key = 'testKey';
      const value = 'testValue';

      // Mock write
      when(
        mockSecureStorage.write(key: key, value: value),
      ).thenAnswer((_) async {});

      // Mock read
      when(mockSecureStorage.read(key: key)).thenAnswer((_) async => value);

      final cacheHelper = container.read(cacheHelperProvider);

      // Write to secure storage
      await cacheHelper.writeString(key, value);

      // Read from secure storage
      final storedValue = await cacheHelper.readString(key);

      expect(storedValue, equals(value));
    },
  );
}
