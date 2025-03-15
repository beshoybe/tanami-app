import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';
import 'package:tanami_capital/features/auth/presentation/providers/confirm_otp/confirm_otp_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/confirm_otp/confirm_otp_states.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/main_auth_layout.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/resend_otp_timer/resend_otp_timer.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';

class ConfirmOtpPage extends ConsumerWidget {
  final String email;
  const ConfirmOtpPage({super.key, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(confirmOtpProvider.notifier);
    final state = ref.watch(confirmOtpProvider);
    ref.listen(confirmOtpProvider, (previous, current) async {
      if (current is ConfirmOtpError) {
        ref.read(confirmOtpControllerProvider).clear();
      }
      if (current is ConfirmOtpSuccess) {
        ResetPasswordRoute(token: current.token).push(context);
      }
    });

    return MainAuthLayout(
      mainTitle: context.tr.forgetPassTitle,
      subTitle: '',
      child: Padding(
        padding: EdgeInsets.all(context.w(20)),
        child: Form(
          key: ref.watch(confirmOtpFormKeyProvider),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.checkEmail,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: context.h(10)),
                Text(
                  context.tr.weSentOtp,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: context.h(20)),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    errorText: state is ConfirmOtpError ? state.message : null,

                    forceErrorState: true,

                    errorBuilder:
                        (errorText, pin) => Builder(
                          builder: (context) {
                            return errorText == null
                                ? SizedBox()
                                : Padding(
                                  padding: EdgeInsets.all(context.w(4)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        errorText,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                        ),
                                      ),
                                      if (state is ConfirmOtpExpired) ...[
                                        SizedBox(width: context.w(8)),
                                        GestureDetector(
                                          onTap:
                                              () => provider.resendOtp(email),
                                          child: Text(
                                            context.tr.resendOtp,
                                            style: TextStyle(
                                              color: context.appTheme.normal,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                          },
                        ),
                    validator: qValidator([
                      IsRequired(context.tr.pleaseEnterOtp),
                      MinLength(6, context.tr.otpMinLength),
                    ]),
                    controller: ref.watch(confirmOtpControllerProvider),
                    autofocus: true,
                    defaultPinTheme: PinTheme(
                      width: context.w(60),
                      height: context.w(60),
                      textStyle: const TextStyle(fontSize: 24),
                      padding: EdgeInsets.all(context.w(8)),

                      decoration: BoxDecoration(
                        color: context.appTheme.white,
                        border: Border.all(
                          color: context.appTheme.border2,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(context.w(8)),
                      ),
                    ),
                    length: 6,
                    keyboardType: TextInputType.number,
                    onCompleted: (value) => provider.confirmOtp(email),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                SizedBox(height: context.h(20)),
                AppButton(
                  loading: state is ConfirmOtpLoading,
                  color: context.appTheme.normal,
                  onPressed: () => provider.confirmOtp(email),
                  child: Text(
                    context.tr.verify,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                if (state is! ConfirmOtpExpired)
                  ResendOtpTimer(onResend: () => provider.resendOtp(email)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
