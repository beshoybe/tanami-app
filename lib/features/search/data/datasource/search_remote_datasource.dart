import 'package:tanami_capital/core/api/api_helper.dart';
import 'package:tanami_capital/features/search/data/datasource/search_datasource.dart';
import 'package:tanami_capital/shared/models/investment_model.dart';

class SearchRemoteDatasource implements SearchDatasource {
  final ApiHelper _apiHelper;

  SearchRemoteDatasource(this._apiHelper);

  @override
  Future<List<InvestmentModel>> getAllInvestments() async {
    final response = await _apiHelper.get('/investments');
    return (response.data['data']['investments'] as List)
        .map((e) => InvestmentModel.fromJson(e))
        .toList();
  }
}
