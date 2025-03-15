import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/api/api_helper.dart';
import 'package:tanami_capital/core/cache/cache_helper.dart';
import 'package:tanami_capital/features/auth/data/datasource/auth_datasource.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';

class AuthRemoteDatasource implements AuthDatasource {
  final ApiHelper dioApiHelper;
  final CacheHelper cacheHelper;

  AuthRemoteDatasource(this.dioApiHelper, this.cacheHelper);

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    final response = await dioApiHelper.post(
      '/auth/login',
      body: {'email': email, 'password': password},
    );
    final resModel = AuthResponseModel.fromJson(response.data['data']);
    await _clearAndSetAuthData(resModel);

    return resModel;
  }

  @override
  Future<AuthResponseModel> passwordLessLogin(String token) async {
    final response = await dioApiHelper.post(
      '/auth/passwordless-login',
      body: {'token': token},
    );
    final resModel = AuthResponseModel.fromJson(response.data['data']);
    await _clearAndSetAuthData(resModel);

    return resModel;
  }

  @override
  Future<AuthResponseModel> signup(
    String email,
    String password,
    String name,
  ) async {
    final response = await dioApiHelper.post(
      '/auth/register',
      body: {'email': email, 'password': password, 'name': name},
    );
    final resModel = AuthResponseModel.fromJson(response.data['data']);
    await _clearAndSetAuthData(resModel);

    return resModel;
  }

  @override
  Future<void> forgetPassword(String email) async {
    await dioApiHelper.post('/auth/forget-password', body: {'email': email});
  }

  @override
  Future<String> confirmOtp(String email, String otp) async {
    final res = await dioApiHelper.post(
      '/auth/confirm-otp',
      body: {'email': email, 'otp': otp},
    );
    final token = res.data['data']['token'];
    return token;
  }

  @override
  Future<AuthResponseModel> resetPassword(String token, String password) async {
    final response = await dioApiHelper.post(
      '/auth/reset-password',
      body: {'password': password, 'token': token},
    );
    final resModel = AuthResponseModel.fromJson(response.data['data']);
    await _clearAndSetAuthData(resModel);

    return resModel;
  }

  Future<void> _clearAndSetAuthData(AuthResponseModel resModel) async {
    await cacheHelper.remove(kTokenCacheKey);
    await cacheHelper.remove(kRefreshTokenCacheKey);
    await cacheHelper.remove(kPasswordLessTokenCacheKey);
    await cacheHelper.writeString(kTokenCacheKey, resModel.token);
    await cacheHelper.writeString(kRefreshTokenCacheKey, resModel.refreshToken);
    await cacheHelper.writeString(
      kPasswordLessTokenCacheKey,
      resModel.passwordLessToken,
    );
  }
}
