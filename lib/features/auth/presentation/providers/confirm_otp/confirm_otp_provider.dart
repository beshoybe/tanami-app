import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/domain/usecases/confirm_otp_usecase.dart';
import 'package:tanami_capital/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/features/auth/presentation/providers/confirm_otp/confirm_otp_states.dart';

part 'confirm_otp_provider.g.dart';

@Riverpod(keepAlive: false)
TextEditingController confirmOtpController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
}

@Riverpod(keepAlive: false)
GlobalKey<FormState> confirmOtpFormKey(Ref ref) {
  return GlobalKey<FormState>();
}

@Riverpod(keepAlive: false)
class ConfirmOtp extends _$ConfirmOtp {
  ConfirmOtpUsecase get _confirmOtpUsecase =>
      ref.read(confirmOtpUsecaseProvider);

  ForgetPasswordUsecase get _forgetPasswordUsecase =>
      ref.read(forgetPasswordUsecaseProvider);

  @override
  ConfirmOtpStates build() {
    return ConfirmOtpInitial();
  }

  Future<void> confirmOtp(String email) async {
    if (!ref.read(confirmOtpFormKeyProvider).currentState!.validate()) {
      state = ConfirmOtpValidationError();
      return;
    }
    state = ConfirmOtpLoading();
    final result = await _confirmOtpUsecase(
      ConfirmOtpParams(
        otp: ref.read(confirmOtpControllerProvider).text,
        email: email,
      ),
    );
    result.fold(
      (failure) {
        if (failure is ServerFailure && failure.statusCode == 410) {
          state = ConfirmOtpExpired(message: failure.message);
          return;
        }
        state = ConfirmOtpError(message: failure.message);
      },
      (success) {
        state = ConfirmOtpSuccess(token: success);
      },
    );
  }

  Future<void> resendOtp(String email) async {
    state = ConfirmOtpLoading();
    final result = await _forgetPasswordUsecase(email);
    result.fold(
      (failure) {
        state = ConfirmOtpError(message: failure.message);
      },
      (success) {
        state = ResendOtpSuccess();
      },
    );
  }
}
