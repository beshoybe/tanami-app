import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/features/home/domain/entities/home_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, HomeEntity>> getHomeData();
}
