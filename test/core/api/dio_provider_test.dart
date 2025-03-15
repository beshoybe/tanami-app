import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/api/language_interceptor.dart';
import 'package:tanami_capital/core/api/token_interceptor.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/core/api/api_provider.dart';

import '../../mock_specs.mocks.dart';

void main() {
  late ProviderContainer container;
  late MockSecureCacheHelper mockCacheHelper;

  setUp(() async {
    await dotenv.load(fileName: '.env');
    mockCacheHelper = MockSecureCacheHelper();

    // Mock the necessary providers
    container = ProviderContainer(
      overrides: [cacheHelperProvider.overrideWithValue(mockCacheHelper)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('Dio provider should have correct interceptors', () async {
    // Mock the return values for cache helper and locale notifier

    // Mock readStringOrNull to return a valid string
    when(
      mockCacheHelper.readStringOrNull(any),
    ).thenAnswer((_) async => 'some-token');

    // Get the Dio instance from the provider
    final dio = container.read(dioProvider);

    // Verify that the interceptors were added
    final interceptors = dio.interceptors;

    expect(interceptors, isNotEmpty);
    expect(
      interceptors.any((interceptor) => interceptor is PrettyDioLogger),
      isTrue,
    );
    expect(
      interceptors.any((interceptor) => interceptor is LanguageInterceptor),
      isTrue,
    );
    expect(
      interceptors.any((interceptor) => interceptor is TokenInterceptor),
      isTrue,
    );
  });

  test('LanguageInterceptor should use the correct locale', () async {
    when(
      mockCacheHelper.readStringOrNull(kSelectedLocaleCacheKey),
    ).thenAnswer((_) async => 'en');
    // Mock readStringOrNull to return a valid string
    when(
      mockCacheHelper.readStringOrNull(kTokenCacheKey),
    ).thenAnswer((_) async => 'some-token');

    final dio = container.read(dioProvider);

    // Verify that the LanguageInterceptor has the correct locale ('fr')
    final languageInterceptor =
        dio.interceptors.firstWhere(
              (interceptor) => interceptor is LanguageInterceptor,
              orElse: () => throw Exception('LanguageInterceptor not found'),
            )
            as LanguageInterceptor;

    expect(languageInterceptor.locale.languageCode, 'en');
  });

  test('TokenInterceptor should use the correct token', () async {
    // Mock the return values for cache helper and locale notifier

    // Mock readStringOrNull to return a valid string
    when(
      mockCacheHelper.readStringOrNull(any),
    ).thenAnswer((_) async => 'some-token');

    final dio = container.read(dioProvider);

    // Verify that the TokenInterceptor has the correct token ('some-token')
    final tokenInterceptor =
        dio.interceptors.firstWhere(
              (interceptor) => interceptor is TokenInterceptor,
              orElse: () => throw Exception('TokenInterceptor not found'),
            )
            as TokenInterceptor;

    expect(tokenInterceptor, isNotNull);
  });
}
