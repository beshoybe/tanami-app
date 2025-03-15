import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/auth_login_option.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';
import 'package:tanami_capital/shared/providers/biometrics/biometrics_provider.dart';
import 'package:tanami_capital/shared/providers/biometrics/biometrics_states.dart';

class BiometricsLoginButton extends ConsumerWidget {
  final VoidCallback onSuccessfulAuth;
  final bool enabled;
  final bool loading;
  const BiometricsLoginButton({
    super.key,
    required this.onSuccessfulAuth,
    this.enabled = true,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(biometricsProvider.notifier);
    ref.watch(biometricsProvider);
    ref.listen(biometricsProvider, (previous, current) async {
      if (current is BiometricsAuthenticatedState) {
        onSuccessfulAuth();
      }
    });
    return ref
        .watch(isBiometricsAvailableProvider)
        .when(
          data: (isAvailable) {
            return isAvailable
                ? AuthLoginOption(
                  loading: loading,
                  enabled: enabled,
                  text: context.tr.loginWithBiometrics,
                  icon: Assets.svg.faceId.path,
                  onTap: () {
                    provider.authWithBiometrics();
                  },
                )
                : SizedBox();
          },
          error: (_, __) => SizedBox(),
          loading: () => SizedBox(),
        );
  }
}
