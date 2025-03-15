import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/shared/providers/biometrics/biometrics_states.dart';
part 'biometrics_provider.g.dart';

final isBiometricsAvailableProvider = FutureProvider<bool>((ref) async {
  return await LocalAuthentication().isDeviceSupported();
});
final canLoginPasswordLessProvider = FutureProvider<bool>((ref) async {
  final hasPin = await ref
      .read(cacheHelperProvider)
      .readStringOrNull(kPasswordLessPinCacheKey);
  final hasToken = await ref
      .read(cacheHelperProvider)
      .readStringOrNull(kPasswordLessTokenCacheKey);
  return hasPin != null && hasToken != null;
});

@Riverpod(keepAlive: false)
class Biometrics extends _$Biometrics {
  @override
  BiometricsStates build() {
    state = BiometricsInitialState();
    return state;
  }

  Future<void> authWithBiometrics() async {
    try {
      final localAuth = LocalAuthentication();
      final isAvailable = await localAuth.isDeviceSupported();
      if (isAvailable) {
        final isAuthenticated = await localAuth.authenticate(
          localizedReason: 'Please authenticate to proceed',
          options: AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
        if (isAuthenticated) {
          state = BiometricsAuthenticatedState();
        } else {
          state = BiometricsUnauthenticatedState();
        }
      } else {
        state = BiometricsErrorState(
          'Biometrics is not available on this device',
        );
      }
    } catch (e) {
      state = BiometricsErrorState(e.toString());
    }
  }
}
