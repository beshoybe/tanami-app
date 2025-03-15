import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/core/api/dio_api_helper.dart';
import 'package:tanami_capital/core/api/api_provider.dart';

import '../../mock_specs.mocks.dart';

// Generate mock classes
void main() {
  late MockDio mockDio;
  late ProviderContainer container;

  setUp(() {
    mockDio = MockDio();
    container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDio)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('Dio instance should be created with correct base URL', () {
    final dio = container.read(dioProvider);
    expect(dio, isA<Dio>());
  });

  test('ApiHelper instance should be created', () {
    final apiHelper = container.read(apiHelperProvider);
    expect(apiHelper, isA<DioApiHelper>());
  });
}
