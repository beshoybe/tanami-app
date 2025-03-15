import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/auth/domain/repositories/auth_repository.dart';

class ConfirmOtpUsecase implements UseCase<String, ConfirmOtpParams> {
  final AuthRepository repository;

  ConfirmOtpUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(ConfirmOtpParams params) {
    return repository.confirmOtp(params.email, params.otp);
  }
}

class ConfirmOtpParams {
  final String otp;
  final String email;

  ConfirmOtpParams({required this.otp, required this.email});
}
