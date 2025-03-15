import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tanami_capital/config/keys.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/features/auth/presentation/providers/password_less_login/password_less_login_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/password_less_login/password_less_login_states.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/auth_login_option.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/or_divider.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/password_less_login/biometrics_login_button.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/password_less_login/pin_login_button.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';
import 'package:tanami_capital/shared/providers/biometrics/biometrics_provider.dart';

class LoginOptions extends ConsumerWidget {
  final bool showEmail;
  final bool showOR;
  const LoginOptions({super.key, this.showEmail = true, this.showOR = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(passwordLessLoginProvider.notifier);
    final state = ref.watch(passwordLessLoginProvider);
    ref.listen(passwordLessLoginProvider, (previous, current) async {
      if (current is PasswordLessLoginSuccess) {
        HomeRoute().go(context);
      }
    });
    return Column(
      children: [
        ref
            .watch(canLoginPasswordLessProvider)
            .when(
              data: (data) {
                return data
                    ? Column(
                      children: [
                        if (showOR) OrDivider(),

                        PinLoginButton(
                          key: kLoginWithPinButtonKey,
                          enabled: state is! PasswordLessLoginLoading,
                          loading:
                              state is PasswordLessLoginLoading && state.isPin,
                          onSuccessfulAuth: () {
                            provider.login(isPin: true);
                          },
                        ),
                        BiometricsLoginButton(
                          key: kLoginWithBiometricsButtonKey,
                          enabled: state is! PasswordLessLoginLoading,
                          loading:
                              state is PasswordLessLoginLoading && !state.isPin,
                          onSuccessfulAuth: () {
                            provider.login(isPin: false);
                          },
                        ),
                      ],
                    )
                    : SizedBox();
              },
              error: (_, __) => SizedBox(),
              loading: () => SizedBox(),
            ),
        if (showEmail)
          AuthLoginOption(
            key: kLoginWithEmailButtonKey,
            text: context.tr.loginWithEmail,
            icon: Assets.svg.email.path,
            enabled: state is! PasswordLessLoginLoading,

            onTap: () => LoginRoute().push(context),
          ),
      ],
    );
  }
}
