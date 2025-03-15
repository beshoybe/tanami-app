import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/auth/domain/repositories/auth_repository.dart';

class ForgetPasswordUsecase implements UseCase<void, String> {
  final AuthRepository repository;

  ForgetPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.forgetPassword(params);
  }
}
