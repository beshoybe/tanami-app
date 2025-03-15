import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/features/auth/presentation/providers/reset_password/reset_password_states.dart';

part 'reset_password_provider.g.dart';

@Riverpod(keepAlive: false)
TextEditingController resetPPasswordController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
}

@Riverpod(keepAlive: false)
TextEditingController resetPConfirmPasswordController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
}

@Riverpod(keepAlive: false)
GlobalKey<FormState> resetPasswordFormKey(Ref ref) {
  return GlobalKey<FormState>();
}

@Riverpod(keepAlive: false)
class ResetPassword extends _$ResetPassword {
  ResetPasswordUsecase get resetPasswordUsecase =>
      ref.read(resetPasswordUsecaseProvider);
  @override
  ResetPasswordStates build() {
    return ResetPasswordInitial();
  }

  void resetPassword(String token) {
    if (!ref.read(resetPasswordFormKeyProvider).currentState!.validate()) {
      return;
    }

    state = ResetPasswordLoading();
    final password = ref.read(resetPPasswordControllerProvider).text;
    resetPasswordUsecase(
      ResetPasswordParams(token: token, password: password),
    ).then((result) {
      result.fold(
        (failure) {
          if (failure is ServerFailure && failure.statusCode == 410) {
            state = ResetPasswordExpired(message: failure.message);
            return;
          }
          state = ResetPasswordError(message: failure.message);
        },
        (data) {
          state = ResetPasswordSuccess();
        },
      );
    });
  }
}
