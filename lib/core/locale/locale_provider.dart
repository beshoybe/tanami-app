import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/cache/cache_helper.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

class LocaleNotifier extends Notifier<Locale> {
  @protected
  CacheHelper get cacheHelper => ref.read(cacheHelperProvider);

  @override
  Locale build() {
    loadLocale();
    return const Locale('en'); // Default locale while loading
  }

  @visibleForTesting
  Future<void> loadLocale() async {
    final savedLocale =
        await cacheHelper.readStringOrNull(kSelectedLocaleCacheKey) ?? 'en';

    if (savedLocale != state.languageCode) {
      state = Locale(savedLocale);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await cacheHelper.writeString(kSelectedLocaleCacheKey, locale.languageCode);
  }
}
