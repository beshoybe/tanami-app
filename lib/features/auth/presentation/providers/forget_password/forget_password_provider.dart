import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/features/auth/presentation/providers/forget_password/forget_password_states.dart';

part 'forget_password_provider.g.dart';

@Riverpod(keepAlive: false)
TextEditingController forgetPasswordEmailController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
}

@Riverpod(keepAlive: false)
GlobalKey<FormState> forgetPasswordFormKey(Ref ref) {
  return GlobalKey<FormState>();
}

@Riverpod(keepAlive: false)
class ForgetPassword extends _$ForgetPassword {
  ForgetPasswordUsecase get forgetPasswordUsecase =>
      ref.read(forgetPasswordUsecaseProvider);

  @override
  ForgetPasswordStates build() {
    return ForgetPasswordInitial();
  }

  Future<void> forgetPassword() async {
    if (!ref.read(forgetPasswordFormKeyProvider).currentState!.validate()) {
      return;
    }
    state = ForgetPasswordLoading();
    final result = await forgetPasswordUsecase(
      ref.read(forgetPasswordEmailControllerProvider).text,
    );
    result.fold(
      (failure) {
        state = ForgetPasswordError(failure.message);
      },
      (success) {
        state = ForgetPasswordSuccess();
      },
    );
  }
}
