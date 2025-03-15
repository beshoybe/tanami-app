import 'package:flutter/material.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/auth_login_option.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/pin_sheet/pin_sheet.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';

class PinLoginButton extends StatelessWidget {
  final VoidCallback onSuccessfulAuth;
  final bool enabled;
  final bool loading;

  const PinLoginButton({
    super.key,
    required this.onSuccessfulAuth,
    this.enabled = true,
    this.loading = false,
  });

  Future<bool> _checkPin(BuildContext context) async {
    final res = await PinSheet.show(context, setNewPin: false);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return AuthLoginOption(
      text: context.tr.loginWithPin,
      icon: Assets.svg.pin.path,
      enabled: enabled,
      loading: loading,
      onTap: () async {
        final res = await _checkPin(context);
        if (res) {
          onSuccessfulAuth();
        }
      },
    );
  }
}
