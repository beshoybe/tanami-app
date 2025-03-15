import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/auth/domain/entities/auth_response_entity.dart';
import 'package:tanami_capital/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase
    implements UseCase<AuthResponseEntity, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUsecase(this.repository);
  @override
  Future<Either<Failure, AuthResponseEntity>> call(ResetPasswordParams params) {
    return repository.resetPassword(params.token, params.password);
  }
}

class ResetPasswordParams {
  final String token;
  final String password;

  ResetPasswordParams({required this.token, required this.password});
}
