import 'package:tanami_capital/shared/entities/investment_history_entity.dart';

class InvestmentHistoryModel extends InvestmentHistoryEntity {
  const InvestmentHistoryModel({
    required super.month,
    required super.profit,
    required super.loss,
  });

  factory InvestmentHistoryModel.fromJson(Map<String, dynamic> json) {
    return InvestmentHistoryModel(
      month: json['month'],
      profit: double.parse(json['profit'].toString()),
      loss: double.parse(json['loss'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'month': month, 'profit': profit, 'loss': loss};
  }
}
