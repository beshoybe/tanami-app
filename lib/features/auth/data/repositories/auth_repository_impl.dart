import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/auth/data/datasource/auth_datasource.dart';
import 'package:tanami_capital/features/auth/domain/entities/auth_response_entity.dart';
import 'package:tanami_capital/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, AuthResponseEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await datasource.login(email, password);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> passwordLessLogin(
    String token,
  ) async {
    try {
      final result = await datasource.passwordLessLogin(token);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> signup(
    String email,
    String password,
    String name,
  ) async {
    try {
      final result = await datasource.signup(email, password, name);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    try {
      final result = await datasource.forgetPassword(email);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> confirmOtp(String email, String otp) async {
    try {
      final result = await datasource.confirmOtp(email, otp);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> resetPassword(
    String token,
    String password,
  ) async {
    try {
      final result = await datasource.resetPassword(token, password);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
