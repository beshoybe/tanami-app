import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/features/auth/domain/usecases/signup_usecase.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/features/auth/presentation/providers/signup/signup_states.dart';
import 'package:tanami_capital/shared/widgets/strong_password_validation/strong_password_validation_provider.dart';

part 'signup_provider.g.dart';

@Riverpod(keepAlive: false)
TextEditingController signupEmailController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
}

@Riverpod(keepAlive: false)
TextEditingController signupPasswordController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
}

@Riverpod(keepAlive: false)
TextEditingController signupFirstNameController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
}

@Riverpod(keepAlive: false)
TextEditingController signupLastNameController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
}

@Riverpod(keepAlive: false)
TextEditingController signupConfirmPasswordController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
}

@Riverpod(keepAlive: false)
GlobalKey<FormState> signupFormKey(Ref ref) => GlobalKey<FormState>();

@Riverpod(keepAlive: false)
class Signup extends _$Signup {
  SignupUsecase get signupUsecase => ref.read(signupUsecaseProvider);
  @override
  SignupStates build() {
    return SignupInitial();
  }

  Future<void> signup() async {
    if (!ref.read(signupFormKeyProvider).currentState!.validate()) return;
    if (ref.read(strongPasswordValidationProvider).numberOfValidations() != 4) {
      state = SignupPasswordNotStrong();
      return;
    }
    state = SignupLoading();
    final result = await signupUsecase(
      SignupParams(
        email: ref.read(signupEmailControllerProvider).text,
        password: ref.read(signupPasswordControllerProvider).text,
        name:
            '${ref.read(signupFirstNameControllerProvider).text} ${ref.read(signupLastNameControllerProvider).text}',
      ),
    );
    result.fold(
      (failure) {
        state = SignupFailure(message: failure.message);
      },
      (success) {
        state = SignupSuccess();
      },
    );
  }
}
