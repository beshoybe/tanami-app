import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/cache/cache_helper.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/features/auth/domain/usecases/password_less_login_usecase.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/features/auth/presentation/providers/password_less_login/password_less_login_states.dart';

part 'password_less_login_provider.g.dart';

@Riverpod(keepAlive: false)
class PasswordLessLogin extends _$PasswordLessLogin {
  PasswordLessLoginUsecase get passwordLessLoginUsecase =>
      ref.read(passwordLessLoginUsecaseProvider);

  CacheHelper get cacheHelper => ref.read(cacheHelperProvider);
  @override
  PasswordLessLoginStates build() {
    state = PasswordLessLoginInitial();
    return state;
  }

  void login({bool isPin = true}) async {
    state = PasswordLessLoginLoading(isPin);
    final token = await cacheHelper.readStringOrNull(
      kPasswordLessTokenCacheKey,
    );
    final result = await passwordLessLoginUsecase(token!);
    state = result.fold(
      (l) => PasswordLessLoginError(l.message),
      (r) => PasswordLessLoginSuccess(),
    );
  }
}
