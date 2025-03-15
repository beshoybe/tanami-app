import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/core/api/api_provider.dart';
import 'package:tanami_capital/features/home/data/datasource/home_datasource.dart';
import 'package:tanami_capital/features/home/data/datasource/home_remote_datasource.dart';
import 'package:tanami_capital/features/home/data/repositories/home_repo_impl.dart';
import 'package:tanami_capital/features/home/domain/repositories/home_repository.dart';
import 'package:tanami_capital/features/home/domain/usecases/home_usecase.dart';

part 'home_di.g.dart';

@Riverpod(keepAlive: false)
HomeDatasource homeDatasource(Ref ref) {
  return HomeRemoteDatasource(apiHelper: ref.watch(apiHelperProvider));
}

@Riverpod(keepAlive: false)
HomeRepository homeRepository(Ref ref) {
  return HomeRepoImpl(ref.watch(homeDatasourceProvider));
}

@Riverpod(keepAlive: false)
HomeUsecase homeUsecase(Ref ref) {
  return HomeUsecase(ref.watch(homeRepositoryProvider));
}
