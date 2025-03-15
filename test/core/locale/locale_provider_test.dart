import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/core/locale/locale_provider.dart';

import '../../mock_specs.mocks.dart';

void main() {
  late ProviderContainer container;
  late MockSecureCacheHelper mockCacheHelper;

  setUp(() {
    mockCacheHelper = MockSecureCacheHelper();

    container = ProviderContainer(
      overrides: [cacheHelperProvider.overrideWithValue(mockCacheHelper)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('LocaleNotifier should start with default locale (en)', () {
    when(
      mockCacheHelper.readStringOrNull(kSelectedLocaleCacheKey),
    ).thenAnswer((_) async => null);
    final localeNotifier = container.read(localeProvider);
    expect(localeNotifier, const Locale('en'));
  });

  test('LocaleNotifier should load saved locale from cache', () async {
    // Mocking the cache read method
    when(
      mockCacheHelper.readStringOrNull(kSelectedLocaleCacheKey),
    ).thenAnswer((_) async => 'fr');

    final notifier = container.read(localeProvider.notifier);
    // This will trigger the build method, which calls _loadLocale internally
    await notifier.loadLocale();

    // Check if the state is updated to the saved locale ('fr')
    expect(notifier.state, const Locale('fr'));
  });

  test('LocaleNotifier should update locale and store in cache', () async {
    when(
      mockCacheHelper.readStringOrNull(kSelectedLocaleCacheKey),
    ).thenAnswer((_) async => 'es');
    final notifier = container.read(localeProvider.notifier);
    const newLocale = Locale('es');

    await notifier.setLocale(newLocale);

    expect(notifier.state, newLocale);
    verify(
      mockCacheHelper.writeString(kSelectedLocaleCacheKey, 'es'),
    ).called(1);
  });
}
