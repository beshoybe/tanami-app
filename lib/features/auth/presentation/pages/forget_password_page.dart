import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/auth/presentation/providers/forget_password/forget_password_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/forget_password/forget_password_states.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/main_auth_layout.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/app_form_field.dart';

class ForgetPasswordPage extends ConsumerWidget {
  final bool navigateAfterFinish;
  const ForgetPasswordPage({super.key, this.navigateAfterFinish = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(forgetPasswordProvider.notifier);
    final state = ref.watch(forgetPasswordProvider);
    ref.listen(forgetPasswordProvider, (previous, current) async {
      if (current is ForgetPasswordSuccess) {
        if (!navigateAfterFinish) {
          return;
        }
        ConfirmOtpRoute(
          email: ref.watch(forgetPasswordEmailControllerProvider).text,
        ).push(context);
      }
    });
    return MainAuthLayout(
      mainTitle: context.tr.forgetPassTitle,
      subTitle: '',
      child: Padding(
        padding: EdgeInsets.all(context.w(20)),
        child: Form(
          key: ref.watch(forgetPasswordFormKeyProvider),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.forgetPassTitle,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: context.h(10)),
                Text(
                  context.tr.forgetPassText,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: context.h(20)),
                AppFormField(
                  error: state is ForgetPasswordError ? state.error : null,
                  validator: qValidator([
                    IsRequired(context.tr.required(context.tr.email)),
                    IsEmail(context.tr.invalidEmailFormat),
                  ]),
                  controller: ref.watch(forgetPasswordEmailControllerProvider),

                  hint: context.tr.enterYour(context.tr.email),
                ),
                SizedBox(height: context.h(20)),
                AppButton(
                  key: Key('forgetPasswordButton'),
                  loading: state is ForgetPasswordLoading,
                  color: context.appTheme.normal,

                  onPressed: provider.forgetPassword,
                  child: Text(
                    context.tr.sendOtp,
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
