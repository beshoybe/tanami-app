import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';

abstract interface class AuthDatasource {
  Future<AuthResponseModel> login(String email, String password);

  Future<AuthResponseModel> passwordLessLogin(String token);

  Future<AuthResponseModel> signup(String email, String password, String name);

  Future<void> forgetPassword(String email);

  Future<String> confirmOtp(String email, String otp);

  Future<AuthResponseModel> resetPassword(String token, String password);
}
