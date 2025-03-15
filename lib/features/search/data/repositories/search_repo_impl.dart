import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/search/data/datasource/search_datasource.dart';
import 'package:tanami_capital/features/search/domain/repositories/search_repository.dart';
import 'package:tanami_capital/shared/entities/investment_entity.dart';

class SearchRepoImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, List<InvestmentEntity>>> getAllInvestments() async {
    try {
      final result = await datasource.getAllInvestments();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
