import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/core/api/api_provider.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/features/auth/data/datasource/auth_datasource.dart';
import 'package:tanami_capital/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:tanami_capital/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tanami_capital/features/auth/domain/repositories/auth_repository.dart';
import 'package:tanami_capital/features/auth/domain/usecases/confirm_otp_usecase.dart';
import 'package:tanami_capital/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:tanami_capital/features/auth/domain/usecases/login_usecase.dart';
import 'package:tanami_capital/features/auth/domain/usecases/password_less_login_usecase.dart';
import 'package:tanami_capital/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:tanami_capital/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_di.g.dart';

@Riverpod(keepAlive: false)
AuthDatasource authDatasource(Ref ref) {
  return AuthRemoteDatasource(
    ref.read(apiHelperProvider),
    ref.read(cacheHelperProvider),
  );
}

@Riverpod(keepAlive: false)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.read(authDatasourceProvider));
}

@Riverpod(keepAlive: false)
LoginUsecase loginUsecase(Ref ref) {
  return LoginUsecase(ref.read(authRepositoryProvider));
}

@Riverpod(keepAlive: false)
PasswordLessLoginUsecase passwordLessLoginUsecase(Ref ref) {
  return PasswordLessLoginUsecase(ref.read(authRepositoryProvider));
}

@Riverpod(keepAlive: false)
SignupUsecase signupUsecase(Ref ref) {
  return SignupUsecase(ref.read(authRepositoryProvider));
}

@Riverpod(keepAlive: false)
ForgetPasswordUsecase forgetPasswordUsecase(Ref ref) {
  return ForgetPasswordUsecase(ref.read(authRepositoryProvider));
}

@Riverpod(keepAlive: false)
ConfirmOtpUsecase confirmOtpUsecase(Ref ref) {
  return ConfirmOtpUsecase(ref.read(authRepositoryProvider));
}

@Riverpod(keepAlive: false)
ResetPasswordUsecase resetPasswordUsecase(Ref ref) {
  return ResetPasswordUsecase(ref.read(authRepositoryProvider));
}
