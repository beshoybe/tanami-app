import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/core/api/api_provider.dart';
import 'package:tanami_capital/features/search/data/datasource/search_datasource.dart';
import 'package:tanami_capital/features/search/data/datasource/search_remote_datasource.dart';
import 'package:tanami_capital/features/search/data/repositories/search_repo_impl.dart';
import 'package:tanami_capital/features/search/domain/repositories/search_repository.dart';
import 'package:tanami_capital/features/search/domain/usecases/get_all_investments_usecase.dart';

part 'search_di.g.dart';

@Riverpod(keepAlive: false)
SearchDatasource searchDatasource(Ref ref) =>
    SearchRemoteDatasource(ref.watch(apiHelperProvider));

@Riverpod(keepAlive: false)
SearchRepository searchRepository(Ref ref) =>
    SearchRepoImpl(datasource: ref.watch(searchDatasourceProvider));

@Riverpod(keepAlive: false)
GetAllInvestmentsUsecase getAllInvestmentsUsecase(Ref ref) =>
    GetAllInvestmentsUsecase(repository: ref.watch(searchRepositoryProvider));
