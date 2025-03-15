import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/cache/cache_helper.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';

final themeProvider =
    NotifierProvider<ThemeProvider, ThemeMode>(ThemeProvider.new);

class ThemeProvider extends Notifier<ThemeMode> {
  ThemeProvider();
  @protected
  CacheHelper get cache => ref.watch(cacheHelperProvider);

  Future<void> init() async {
    final mode = await cache.readStringOrNull(kThemeCacheKey);
    state = ThemeMode.values.firstWhere(
      (e) => e.name == mode,
      orElse: () => ThemeMode.light,
    );
  }

  Future<void> animateTo(ThemeMode newMode) async {
    state = newMode;
    await cache.writeString(kThemeCacheKey, newMode.name);
  }

  @override
  ThemeMode build() {
    init();
    return ThemeMode.light;
  }
}
