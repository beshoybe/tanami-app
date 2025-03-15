import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:tanami_capital/config/keys.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/auth/presentation/providers/login/login_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/login/login_states.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/password_less_login/login_options.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/pin_sheet/pin_sheet.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/app_form_field.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(loginProvider.notifier);
    final state = ref.watch(loginProvider);
    ref.listen(loginProvider, (previous, current) async {
      if (current is LoginSuccess) {
        PinSheet.pinSet(context, ref);
      }
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: context.h(32)),
        child: SingleChildScrollView(
          child: Form(
            key: ref.watch(loginFormKeyProvider),
            child: Column(
              children: [
                AppFormField(
                  key: kLoginEmailFieldKey,
                  enabled: state is! LoginLoading,
                  error: state is LoginInvalidEmail ? state.message : null,
                  controller: ref.watch(loginEmailControllerProvider),
                  label: context.tr.email,
                  validator: qValidator([
                    IsRequired(context.tr.required(context.tr.email)),
                    IsEmail(context.tr.invalidEmailFormat),
                  ]),
                ),
                SizedBox(height: context.h(4)),
                AppFormField(
                  key: kLoginPasswordFieldKey,
                  enabled: state is! LoginLoading,
                  controller: ref.watch(loginPasswordControllerProvider),
                  label: context.tr.password,
                  error: state is LoginInvalidPassword ? state.message : null,
                  isPassword: true,
                  validator: qValidator([
                    IsRequired(context.tr.required(context.tr.password)),
                    MinLength(6, context.tr.passwordMinLength),
                  ]),
                ),
                SizedBox(height: context.h(8)),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => ForgetPasswordRoute().push(context),
                    child: Text(
                      context.tr.forgetPassword,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.appTheme.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.h(16)),
                AppButton(
                  key: kLoginButtonKey,
                  loading: state is LoginLoading,
                  color: context.appTheme.normal,
                  hoverColor: context.appTheme.lightHover,
                  onPressed: provider.login,
                  child: Text(
                    context.tr.login,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: context.h(16)),
                LoginOptions(showEmail: false, showOR: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
