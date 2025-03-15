import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/home/data/datasource/home_datasource.dart';
import 'package:tanami_capital/features/home/domain/entities/home_entity.dart';
import 'package:tanami_capital/features/home/domain/repositories/home_repository.dart';

class HomeRepoImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepoImpl(this.datasource);

  @override
  Future<Either<Failure, HomeEntity>> getHomeData() async {
    try {
      final result = await datasource.getHomeData();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
