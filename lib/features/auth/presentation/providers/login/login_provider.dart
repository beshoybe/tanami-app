import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/domain/usecases/login_usecase.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/features/auth/presentation/providers/login/login_states.dart';

part 'login_provider.g.dart';

@Riverpod(keepAlive: false)
GlobalKey<FormState> loginFormKey(Ref ref) => GlobalKey<FormState>();

@Riverpod(keepAlive: false)
TextEditingController loginEmailController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
}

@Riverpod(keepAlive: false)
TextEditingController loginPasswordController(Ref ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
}

@Riverpod(keepAlive: false)
class Login extends _$Login {
  LoginUsecase get loginUsecase => ref.read(loginUsecaseProvider);

  void login() async {
    final formKey = ref.read(loginFormKeyProvider);
    if (!formKey.currentState!.validate()) {
      state = LoginFailure('Invalid form');
      return;
    }
    state = LoginLoading();
    final email = ref.read(loginEmailControllerProvider).text;
    final password = ref.read(loginPasswordControllerProvider).text;
    final result = await loginUsecase(
      LoginParams(email: email, password: password),
    );
    result.fold(
      (l) {
        log('Login Error: ${l.message}');
        if (l is ServerFailure) {
          if (l.statusCode == 404) {
            state = LoginInvalidEmail(l.message);
            return;
          } else if (l.statusCode == 401) {
            state = LoginInvalidPassword(l.message);
            return;
          }
        }
        state = LoginFailure(l.message);
      },
      (r) {
        state = LoginSuccess();
      },
    );
  }

  @override
  LoginState build() {
    state = LoginInitial();
    return state;
  }
}
