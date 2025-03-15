import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:tanami_capital/config/keys.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/auth/presentation/providers/signup/signup_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/signup/signup_states.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/pin_sheet/pin_sheet.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/app_dialog.dart';
import 'package:tanami_capital/shared/widgets/app_form_field.dart';
import 'package:tanami_capital/shared/widgets/strong_password_validation/strong_password_validation.dart';
import 'package:tanami_capital/shared/widgets/strong_password_validation/strong_password_validation_provider.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(signupProvider.notifier);
    final state = ref.watch(signupProvider);
    ref.listen(signupProvider, (previous, current) async {
      if (current is SignupSuccess) {
        PinSheet.pinSet(
          context,
          ref,
          failRouterCallback: AuthOptionsRoute().location,
        );
      } else if (current is SignupFailure) {
        AppDialog.show(
          context,
          title: context.tr.error,
          content: current.message,
          action: AppButton(
            color: context.appTheme.normal,
            child: Text(
              context.tr.close,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      }
    });
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: context.h(32)),
        child: SingleChildScrollView(
          child: Form(
            key: ref.watch(signupFormKeyProvider),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppFormField(
                        key: kSignupFirstNameFieldKey,
                        enabled: state is! SignupLoading,
                        controller: ref.watch(
                          signupFirstNameControllerProvider,
                        ),
                        label: context.tr.firstName,
                        hint: context.tr.enter(
                          context.tr.firstName.toLowerCase(),
                        ),
                        validator: qValidator([
                          IsRequired(context.tr.required(context.tr.firstName)),
                        ]),
                      ),
                    ),
                    SizedBox(width: context.w(4)),
                    Expanded(
                      child: AppFormField(
                        key: kSignupLastNameFieldKey,
                        enabled: state is! SignupLoading,
                        controller: ref.watch(signupLastNameControllerProvider),
                        label: context.tr.lastName,
                        hint: context.tr.enter(
                          context.tr.lastName.toLowerCase(),
                        ),
                        validator: qValidator([
                          IsRequired(context.tr.required(context.tr.lastName)),
                        ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.h(4)),
                AppFormField(
                  key: kSignupEmailFieldKey,
                  enabled: state is! SignupLoading,
                  controller: ref.watch(signupEmailControllerProvider),
                  label: context.tr.email,
                  hint: context.tr.enter(context.tr.email.toLowerCase()),
                  validator: qValidator([
                    IsRequired(context.tr.required(context.tr.email)),
                    IsEmail(context.tr.invalidEmailFormat),
                  ]),
                ),
                SizedBox(height: context.h(4)),
                AppFormField(
                  key: kSignupPasswordFieldKey,
                  enabled: state is! SignupLoading,
                  controller: ref.watch(signupPasswordControllerProvider),
                  label: context.tr.password,
                  isPassword: true,
                  hint: context.tr.enter(context.tr.password.toLowerCase()),
                  onChanged: (p0) {
                    ref
                        .read(strongPasswordValidationProvider.notifier)
                        .validatePassword(p0);
                  },
                  validator: qValidator([
                    IsRequired(context.tr.required(context.tr.password)),
                  ]),
                ),
                StrongPasswordValidation(),
                SizedBox(height: context.h(8)),
                AppFormField(
                  key: kSignupConfirmPasswordFieldKey,
                  enabled: state is! SignupLoading,
                  controller: ref.watch(
                    signupConfirmPasswordControllerProvider,
                  ),
                  label: context.tr.confirmPassword,
                  hint: context.tr.enter(context.tr.password.toLowerCase()),
                  isPassword: true,

                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return context.tr.required(context.tr.password);
                    }
                    if (val !=
                        ref.read(signupPasswordControllerProvider).text) {
                      return context.tr.passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.h(16)),
                AppButton(
                  key: kSignupButtonKey,
                  color: context.appTheme.normal,
                  onPressed: provider.signup,
                  loading: state is SignupLoading,
                  child: Text(
                    context.tr.signup,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
