import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/cache/cache_helper.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/pin_provider/pin_states.dart';

part 'pin_provider.g.dart';

@Riverpod(keepAlive: false)
class Pin extends _$Pin {
  CacheHelper get cacheHelper => ref.read(cacheHelperProvider);

  @override
  PinStates build() {
    state = PinInitial();
    return state;
  }

  Future<void> setPin(String pin) async {
    try {
      state = PinLoading();
      await cacheHelper.writeString(kPasswordLessPinCacheKey, pin);
      state = PinSuccess();
    } catch (e) {
      state = PinError(message: e.toString());
    }
  }

  Future<void> verifyPin(String pin) async {
    try {
      state = PinLoading();
      final savedPin = await cacheHelper.readStringOrNull(
        kPasswordLessPinCacheKey,
      );
      if (savedPin == pin) {
        state = PinSuccess();
      } else {
        state = PinInvalidPin();
      }
    } catch (e) {
      state = PinError(message: e.toString());
    }
  }
}
