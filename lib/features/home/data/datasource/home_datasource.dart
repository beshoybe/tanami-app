import 'package:tanami_capital/features/home/data/models/home_model.dart';

abstract interface class HomeDatasource {
  Future<HomeModel> getHomeData();
}
