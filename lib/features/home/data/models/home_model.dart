import 'package:tanami_capital/features/home/domain/entities/home_entity.dart';
import 'package:tanami_capital/shared/models/investment_history_model.dart';
import 'package:tanami_capital/shared/models/investment_model.dart';
import 'package:tanami_capital/shared/models/user_model.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.user,
    required super.investmentHistories,
    required super.bestInvestments,
    required super.totalInvestments,
    required super.max,
    required super.min,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final userInvestment = json['user_investments'] ?? {};
    final investmentHistories =
        (userInvestment['history'] as List?)
            ?.map((history) => InvestmentHistoryModel.fromJson(history))
            .toList()
            .cast<InvestmentHistoryModel>() ??
        [];

    final bestInvestments =
        (json['best_investments'] as List?)
            ?.map((investment) => InvestmentModel.fromJson(investment))
            .toList()
            .cast<InvestmentModel>() ??
        [];

    return HomeModel(
      user: UserModel.fromJson(json['user'] ?? {}),
      investmentHistories: investmentHistories,
      bestInvestments: bestInvestments,
      totalInvestments:
          double.tryParse(userInvestment['total'].toString()) ?? 0,
      max: double.tryParse(userInvestment['highest'].toString()) ?? 0,
      min: double.tryParse(userInvestment['lowest'].toString()) ?? 0,
    );
  }
}
