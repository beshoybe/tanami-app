import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/api/token_interceptor.dart';

import '../../mock_specs.mocks.dart';

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

void main() {
  late TokenInterceptor tokenInterceptor;
  late MockCacheHelper mockCacheHelper;
  late MockRequestInterceptorHandler mockHandler;

  setUp(() {
    mockCacheHelper = MockCacheHelper();
    mockHandler = MockRequestInterceptorHandler();
    tokenInterceptor = TokenInterceptor(mockCacheHelper);
  });

  test(
    'TokenInterceptor should add Authorization header if token exists',
    () async {
      const mockToken = 'mock_access_token';
      when(
        mockCacheHelper.readStringOrNull(kTokenCacheKey),
      ).thenAnswer((_) async => mockToken);

      final requestOptions = RequestOptions(path: '/test');

      await tokenInterceptor.onRequest(
        requestOptions,
        mockHandler,
      ); // Add await

      expect(requestOptions.headers['Authorization'], 'Bearer $mockToken');
    },
  );

  test(
    'TokenInterceptor should not add Authorization header if token is null',
    () async {
      when(
        mockCacheHelper.readStringOrNull(kTokenCacheKey),
      ).thenAnswer((_) async => null);

      final requestOptions = RequestOptions(path: '/test');

      tokenInterceptor.onRequest(requestOptions, mockHandler);

      expect(requestOptions.headers.containsKey('Authorization'), isFalse);
    },
  );
}
