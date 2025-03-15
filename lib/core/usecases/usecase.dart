import 'package:dartz/dartz.dart';
import 'package:tanami_capital/core/errors/base.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  NoParams();
}
