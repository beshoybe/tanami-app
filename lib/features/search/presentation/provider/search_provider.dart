import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/search/search_di.dart';
import 'package:tanami_capital/shared/entities/investment_entity.dart';

part 'search_provider.g.dart';

@Riverpod(keepAlive: false)
Future<List<InvestmentEntity>> allInvestments(Ref ref) async {
  final investments = await ref
      .read(getAllInvestmentsUsecaseProvider)
      .call(NoParams());
  return investments.fold((l) => throw l, (r) => r);
}
