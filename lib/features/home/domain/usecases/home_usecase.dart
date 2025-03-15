import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/home/domain/entities/home_entity.dart';
import 'package:tanami_capital/features/home/domain/repositories/home_repository.dart';

class HomeUsecase implements UseCase<HomeEntity, NoParams> {
  final HomeRepository repository;

  HomeUsecase(this.repository);

  @override
  Future<Either<Failure, HomeEntity>> call(NoParams params) {
    return repository.getHomeData();
  }
}
