import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/shared/providers/biometrics/biometrics_provider.dart';

part 'logout_provider.g.dart';

@Riverpod(keepAlive: false)
Future<void> logout(Ref ref) async {
  final cacheHelper = ref.read(cacheHelperProvider);
  await cacheHelper.remove(kTokenCacheKey);
  await cacheHelper.remove(kRefreshTokenCacheKey);
  await cacheHelper.remove(kPasswordLessPinCacheKey);
  await cacheHelper.remove(kPasswordLessTokenCacheKey);
  ref.invalidate(canLoginPasswordLessProvider);
}
