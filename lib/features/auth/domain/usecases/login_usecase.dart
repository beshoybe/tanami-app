import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/auth/domain/entities/auth_response_entity.dart';
import 'package:tanami_capital/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase implements UseCase<AuthResponseEntity, LoginParams> {
  final AuthRepository repository;

  LoginUsecase(this.repository);
  @override
  Future<Either<Failure, AuthResponseEntity>> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
