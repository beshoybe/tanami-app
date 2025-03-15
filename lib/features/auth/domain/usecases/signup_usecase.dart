import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/auth/domain/entities/auth_response_entity.dart';
import 'package:tanami_capital/features/auth/domain/repositories/auth_repository.dart';

class SignupUsecase implements UseCase<AuthResponseEntity, SignupParams> {
  final AuthRepository repository;

  SignupUsecase(this.repository);

  @override
  Future<Either<Failure, AuthResponseEntity>> call(SignupParams params) {
    return repository.signup(params.email, params.password, params.name);
  }
}

class SignupParams {
  final String email;
  final String password;
  final String name;

  SignupParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
