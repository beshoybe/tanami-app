import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/auth/domain/entities/auth_response_entity.dart';
import 'package:tanami_capital/features/auth/domain/repositories/auth_repository.dart';

class PasswordLessLoginUsecase implements UseCase<AuthResponseEntity, String> {
  final AuthRepository repository;

  PasswordLessLoginUsecase(this.repository);
  @override
  Future<Either<Failure, AuthResponseEntity>> call(String params) {
    return repository.passwordLessLogin(params);
  }
}
