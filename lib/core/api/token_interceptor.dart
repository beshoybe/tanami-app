import 'package:dio/dio.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/cache/cache_helper.dart';

class TokenInterceptor extends Interceptor {
  final CacheHelper cacheHelper;

  TokenInterceptor(this.cacheHelper);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await cacheHelper.readStringOrNull(kTokenCacheKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
