import 'package:tanami_capital/core/api/api_helper.dart';
import 'package:tanami_capital/features/home/data/datasource/home_datasource.dart';
import 'package:tanami_capital/features/home/data/models/home_model.dart';

class HomeRemoteDatasource implements HomeDatasource {
  final ApiHelper apiHelper;

  HomeRemoteDatasource({required this.apiHelper});

  @override
  Future<HomeModel> getHomeData() async {
    final response = await apiHelper.get('/home');
    return HomeModel.fromJson(response.data['data']);
  }
}
