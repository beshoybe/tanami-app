import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/auth/presentation/providers/reset_password/reset_password_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/reset_password/reset_password_states.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/main_auth_layout.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/pin_sheet/pin_sheet.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/app_dialog.dart';
import 'package:tanami_capital/shared/widgets/app_form_field.dart';
import 'package:tanami_capital/shared/widgets/strong_password_validation/strong_password_validation.dart';
import 'package:tanami_capital/shared/widgets/strong_password_validation/strong_password_validation_provider.dart';

class ResetPasswordPage extends ConsumerWidget {
  final String token;
  const ResetPasswordPage({super.key, required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(resetPasswordProvider.notifier);
    final state = ref.watch(resetPasswordProvider);
    ref.listen(resetPasswordProvider, (previous, current) async {
      if (current is ResetPasswordSuccess) {
        PinSheet.pinSet(
          context,
          ref,
          failRouterCallback: AuthOptionsRoute().location,
        );
      } else if (current is ResetPasswordError) {
        ref.read(resetPPasswordControllerProvider).clear();
        ref.read(resetPConfirmPasswordControllerProvider).clear();
        AppDialog.show(
          context,
          title: context.tr.error,
          content: current.message,
          action: AppButton(
            child: Text(context.tr.ok),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      } else if (current is ResetPasswordExpired) {
        AppDialog.show(
          context,
          title: context.tr.error,
          content: current.message,
          action: AppButton(
            child: Text(context.tr.ok),
            onPressed: () => AuthOptionsRoute().go(context),
          ),
        );
      }
    });
    return MainAuthLayout(
      mainTitle: context.tr.createNewPassword,
      subTitle: '',
      child: Padding(
        padding: EdgeInsets.all(context.w(20)),
        child: Form(
          key: ref.watch(resetPasswordFormKeyProvider),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.createNewPassword,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: context.h(10)),
                Text(
                  context.tr.enterNewPass,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: context.h(20)),
                AppFormField(
                  controller: ref.watch(resetPPasswordControllerProvider),
                  label: context.tr.newPassword,
                  hint: context.tr.enterYour(context.tr.password),
                  isPassword: true,
                  onChanged:
                      (p0) => ref
                          .read(strongPasswordValidationProvider)
                          .validatePassword(p0),
                  validator: qValidator([
                    IsRequired(context.tr.required(context.tr.password)),
                    MinLength(6, context.tr.passwordMinLength),
                  ]),
                ),
                StrongPasswordValidation(),
                SizedBox(height: context.h(20)),
                AppFormField(
                  controller: ref.watch(
                    resetPConfirmPasswordControllerProvider,
                  ),
                  label: context.tr.confirmNewPassword,
                  hint: context.tr.enterYour(context.tr.password),
                  isPassword: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return context.tr.required(context.tr.password);
                    }
                    if (val !=
                        ref.watch(resetPPasswordControllerProvider).text) {
                      return context.tr.passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.h(20)),
                AppButton(
                  key: ValueKey('reset_password_btn'),
                  color: context.appTheme.normal,
                  loading: state is ResetPasswordLoading,
                  onPressed: () => provider.resetPassword(token),
                  child: Text(
                    context.tr.resetPassword,
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
