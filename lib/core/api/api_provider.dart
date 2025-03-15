import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/core/api/api_helper.dart';
import 'package:tanami_capital/core/api/dio_api_helper.dart';
import 'package:tanami_capital/core/api/language_interceptor.dart';
import 'package:tanami_capital/core/api/token_interceptor.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/core/locale/locale_provider.dart';

part 'api_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get('BASE_URL'),
      validateStatus: (status) => true,
    ),
  );
  dio.interceptors.addAll([
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
    LanguageInterceptor(ref.watch(localeProvider)),
    TokenInterceptor(ref.watch(cacheHelperProvider)),
  ]);
  return dio;
}

@Riverpod(keepAlive: true)
ApiHelper apiHelper(Ref ref) {
  return DioApiHelper(ref.watch(dioProvider));
}
