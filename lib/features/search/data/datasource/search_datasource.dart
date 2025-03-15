import 'package:tanami_capital/shared/models/investment_model.dart';

abstract interface class SearchDatasource {
  Future<List<InvestmentModel>> getAllInvestments();
}
