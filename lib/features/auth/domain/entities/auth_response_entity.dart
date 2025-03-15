import 'package:equatable/equatable.dart';

class AuthResponseEntity extends Equatable {
  final String token;
  final String refreshToken;
  final String passwordLessToken;

  const AuthResponseEntity({
    required this.token,
    required this.refreshToken,
    required this.passwordLessToken,
  });

  @override
  List<Object?> get props => [token, refreshToken, passwordLessToken];
}
