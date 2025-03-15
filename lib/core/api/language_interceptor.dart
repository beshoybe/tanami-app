import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class LanguageInterceptor extends Interceptor {
  final Locale locale;

  LanguageInterceptor(this.locale);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = locale.languageCode;
    super.onRequest(options, handler);
  }
}
