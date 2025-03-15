import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/api/language_interceptor.dart';

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

void main() {
  late LanguageInterceptor languageInterceptor;
  late MockRequestInterceptorHandler mockHandler;

  setUp(() {
    languageInterceptor = LanguageInterceptor(
      const Locale('en'),
    ); // Mock locale
    mockHandler = MockRequestInterceptorHandler();
  });

  test('LanguageInterceptor should add Accept-Language header', () {
    final requestOptions = RequestOptions(path: '/test');

    languageInterceptor.onRequest(requestOptions, mockHandler);

    expect(requestOptions.headers['Accept-Language'], 'en');
  });
}
