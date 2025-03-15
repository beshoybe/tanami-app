import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/search/domain/repositories/search_repository.dart';
import 'package:tanami_capital/shared/entities/investment_entity.dart';

class GetAllInvestmentsUsecase
    implements UseCase<List<InvestmentEntity>, NoParams> {
  final SearchRepository repository;

  GetAllInvestmentsUsecase({required this.repository});
  @override
  Future<Either<Failure, List<InvestmentEntity>>> call(NoParams params) {
    return repository.getAllInvestments();
  }
}
