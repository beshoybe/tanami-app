import 'package:tanami_capital/features/auth/domain/entities/auth_response_entity.dart';

class AuthResponseModel extends AuthResponseEntity {
  const AuthResponseModel({
    required super.token,
    required super.refreshToken,
    required super.passwordLessToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'],
      refreshToken: json['refresh_token'],
      passwordLessToken: json['password_less_token'],
    );
  }
}
