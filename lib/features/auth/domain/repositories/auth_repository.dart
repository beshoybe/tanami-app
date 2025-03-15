import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/domain/entities/auth_response_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AuthResponseEntity>> login(
    String email,
    String password,
  );

  Future<Either<Failure, AuthResponseEntity>> passwordLessLogin(String token);

  Future<Either<Failure, AuthResponseEntity>> signup(
    String email,
    String password,
    String name,
  );

  Future<Either<Failure, void>> forgetPassword(String email);

  Future<Either<Failure, String>> confirmOtp(String email, String otp);

  Future<Either<Failure, AuthResponseEntity>> resetPassword(
    String token,
    String password,
  );
}
