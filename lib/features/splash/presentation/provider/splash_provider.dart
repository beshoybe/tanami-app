import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tanami_capital/core/cache/cache_helper.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/features/splash/presentation/provider/splash_states.dart';
import 'package:tanami_capital/shared/providers/biometrics/biometrics_provider.dart';

final splashProvider =
    AutoDisposeNotifierProvider<SplashProvider, SplashStates>(
      SplashProvider.new,
    );

class SplashProvider extends AutoDisposeNotifier<SplashStates> {
  @protected
  CacheHelper get cacheHelper => ref.read(cacheHelperProvider);

  @override
  SplashStates build() {
    init();
    return SplashInitialState();
  }

  Future<void> init() async {
    // Simulate Checking for app updates or other initializations
    await ref.read(canLoginPasswordLessProvider.future);
    await ref.read(isBiometricsAvailableProvider.future);
    await Future.delayed(const Duration(seconds: 2));

    state = SplashLoadedState();
  }
}
