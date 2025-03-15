import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/shared/entities/investment_entity.dart';

abstract interface class SearchRepository {
  Future<Either<Failure, List<InvestmentEntity>>> getAllInvestments();
}
